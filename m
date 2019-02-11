Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D89BC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 17:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034302229E
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 17:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfBKRpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:45:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44907 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfBKRpu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 12:45:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so5613382plq.11;
        Mon, 11 Feb 2019 09:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=qsiNNTItaBu0vfSup9FwxcO/VPs5MbG2UZ/fV41EAR4=;
        b=fOf78jq2raLI6tFVBNv/0m8YwkPhv8gDcSmiHIgMm0C6biUhIEOJk37H85T2ovbqTx
         sSrdx7UWMhFXSs7O21mX+LhISXrG8rH4LgGJWDFFehpESLSedrgchUjLj+iNbxyWnv4x
         i33we4ivTl20ilajZh3BePeTfM2R8BEpSBA77WSzKK/XImQMph4M1h+jjHkLQgEHlgIm
         MFF7WqIdsoGFdkfXTd7yUw0PY8c36ntuDJVPGwh0ErJQKuJ9dlPv2Y8d0NEW9GsYq8fL
         zhorZAXc6+XwjmCRh5BhiXx08as4eOEzMAG8/KwQ4ZhF7Fe2q91FrKeL4QgNp/2xCB3q
         ShSw==
X-Gm-Message-State: AHQUAuYgjU7sIaPwlQwmzBRXe+1dub2aIJV7iQQVDzv/Hdw0H6AAxkxS
        xA0zImU1u+xvhBbBMzgLJIzfxkEF
X-Google-Smtp-Source: AHgI3IYrWQi26/Fe7k4tFNmWl4T81kQpzRnofnJqKNF0Rl66FUq1ylA8IsPB6nq0/+0Uc7PNrXe4Bw==
X-Received: by 2002:a17:902:9b87:: with SMTP id y7mr38784059plp.336.1549907149433;
        Mon, 11 Feb 2019 09:45:49 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id n186sm16156617pfn.137.2019.02.11.09.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 09:45:48 -0800 (PST)
Message-ID: <1549907147.19311.16.camel@acm.org>
Subject: [LSF/MM TOPIC] Atomic Writes
From:   Bart Van Assche <bvanassche@acm.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 11 Feb 2019 09:45:47 -0800
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Background
----------
Atomic writes are writes that either succeed in their entirety or that are
not executed if a power failure occurs. It is well known that using atomic
writes can improve database and filesystem performance significantly +AFs-1,2+AF0.
Although the NVMe and SCSI standards support atomic writes, neither the
block layer nor filesystems offer a standardized interface for submitting
atomic writes. Hence the proposal to add block device and filesystem
independent interfaces for atomic writes.

Block Layer Proposal
--------------------
+ACo Block drivers (NVMe, SCSI, ...) that support atomic writes set a queue
  flag that makes it clear to the block layer core that support for atomic
  writes is present.
+ACo Atomic writes are submitted from kernel context by marking individual
  requests as atomic. One possible approach is to introduce a new bio flag.
  Another possible approach is to introduce a new request type, e.g.
  REQ+AF8-OP+AF8-ATOMIC+AF8-WRITE.
+ACo Introduce new limits for atomic writes such that it is guaranteed that
  atomic writes will respect the device atomic write alignment and size
  restrictions. We will probably need limits that correspond to the NAWUN,
  NAWUNPF, NABSN, NABO and NABSPF parameters from the NVMe Identify
  Namespace response.
+ACo Kernel code that submits atomic writes is responsible for ensuring that
  the write request size does not exceed the maximum size advertised by the
  request queue. Fail atomic writes that are too large, not aligned or do
  not satisfy the atomic write limits in some other way. 
+ACo Add support in blk+AF8-stack+AF8-limits() for the atomic write limits.
+ACo Allow merging of regular writes with other regular writes. Allow merging
  of atomic writes with other atomic writes. Do not allow merging of regular
  writes with atomic writes. Respect the device limits when merging atomic
  write requests.
+ACo Continue allowing splitting of regular write requests but do not allow
  splitting of atomic writes.
+ACo Make it possible to submit atomic writes from user space. One possible
  approach is to add an O+AF8-ATOMIC flag to the open() system call.
+ACo Applications that want to submit both atomic and non-atomic writes must
  open the block device twice - once with and once without the O+AF8-ATOMIC
  flag.
+ACo Another possible approach is to add a new flag to the flags arguments of
  the pwritev2() system call and the asynchronous I/O iocb structure.

Filesystem Proposal
-------------------
+ACo Make it possible to submit atomic writes from user space. Just like for
  block devices, one possible approach is to add an O+AF8-ATOMIC flag to the
  open() system call. Another possible approach is to add a new flag to the
  flags arguments of the pwritev2() system call and the asynchronous I/O iocb
  structure. Note: Chris Mason had already proposed in 2013 to introduce the
  O+AF8-ATOMIC flag for filesystems +AFs-3+AF0.
+ACo Filesystems may but do not have to submit atomic writes to the block layer
  to implement O+AF8-ATOMIC. Using a traditional transaction mechanism to
  implement O+AF8-ATOMIC is also fine but will result in write amplification.
+ACo Introduce a standardized interface for querying the filesystem atomic write
  limits, e.g. by adding attributes under /sys/fs/.

References
----------
+AFs-1+AF0 Ouyang, Xiangyong+ADs Nellans, David+ADs Wipfel, Robert+ADs Flynn, David+ADs Panda,
    Dhabaleswar K. (February 2011). +ACI-Beyond block I/O: Rethinking traditional
    storage primitives+ACI. 2011 IEEE 17th International Symposium on High
    Performance Computer Architecture: 301+IBM-311
    (http://citeseerx.ist.psu.edu/viewdoc/download?doi+AD0-10.1.1.300.4140+ACY-rep+AD0-rep1+ACY-type+AD0-pdf). 
+AFs-2+AF0 MariaDB Knowledgebase, Atomic Write Support
    (https://mariadb.com/kb/en/library/atomic-write-support/).
+AFs-3+AF0 Chris Mason, Support for atomic IOs, fsdevel mailing list, November 2013
    (https://linux-fsdevel.vger.kernel.narkive.com/ba1zJRo7/patch-0-2-support-for-atomic-ios).
+AFs-4+AF0 Jonathan Corbet, Atomic I/O Operations, March 2013
    (https://lwn.net/Articles/552095/). 
+AFs-5+AF0 Jonathan Corbet, Support for atomic block I/O operations, November 2013
    (https://lwn.net/Articles/573092/).
