Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF241C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F4A206DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BtYnWEZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgHDJHG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgHDJHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:07:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC539C06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:07:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so21834811qtp.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bTdvrExZaKC0j2udF1+3J/5he8xgyaRLwD31+bm6mBU=;
        b=BtYnWEZvV5QydwmBf4vShTH4BVIhpUq0Y5OfmB8V9HV4RMN8zPhlJ7JjZ3NoN9dHLm
         WcLmpRYtRpcC8a2mUSOUB1QO/FodjFDDTHX7pv6VLpDOJeJm0psvkbNvrhdXP2IaQTn4
         tmx2zRLbREgNZT27RwG6ThCPv9CxLc/DTRwiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bTdvrExZaKC0j2udF1+3J/5he8xgyaRLwD31+bm6mBU=;
        b=dyYmPOmjPQ9BEacTGYW11vZBoyM6RxjXJeuou64I0Z24T4KNYX0j2p6/Xrg1/B+Zow
         vRhIS2bOYfwZEwTQg2AlqQYVmzeDpxtiwMg1+uEetMBu6wr9vFFeTM0QKuuyTRSZASlV
         Y9oitRqb/WYspVPcsd/RtBNeTsIc6a2W4Zp+/3QBrOykK+kIG/4Oui2Cu7k5bkKbx3Rf
         +GDF96zAlEUbjIHhfsYPHOWEE+f1ygkH96j4kt8sxcbqdGJQjTzr94l/9J7r0vYpWeip
         bnONvJEkxEdf+BuVhzayMhPHrxN6/DVjIt9UGlNRzh/1mZ51MDyvrMF0/mTbAX54sejw
         mXOg==
X-Gm-Message-State: AOAM532dZPeLb2nWB0nD5HXZhY43Jlx6ew+ZgKOrFkQWPd24H5R4y2iT
        4rHDU+8afSinZctySUARRVdQqYnTkLfI6jfPEceS+ac7fLBEhfADOsf0/iRP/Yo7Sp21Nqvxls0
        8VVJjF3dTPoK+9/sxv8qKHkmBMjhj5QlXritu5HgE25TjnT6jC5FT9l9UQVbjJIwfUBpyO5KP46
        almfBzvjc=
X-Google-Smtp-Source: ABdhPJwo2uH9VpJCRm6pE7ZNfdhwgQ5tK4MKfwp0Z6PsaOaPQVY1Ke+PjNulKHLbrKoK46IEXBVeSg==
X-Received: by 2002:ac8:e89:: with SMTP id v9mr20938810qti.100.1596532023161;
        Tue, 04 Aug 2020 02:07:03 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 65sm19989407qkn.103.2020.08.04.02.07.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:07:02 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC 00/16] Application specific identification support
Date:   Tue,  4 Aug 2020 07:43:00 +0530
Message-Id: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various virtualization technologies used in Fibre Channel
SAN deployments have created the opportunity to identify
and associate traffic with specific virtualized applications.
 
The concepts behind the T11 Application Services standard is
to provide the general mechanisms needed to identify
virtualized services.
 
This patch set enables the Fabric and the storage targets to
identify, monitor, and handle FC traffic
based on VMID .
 
It added a new knob app_identifier in blkio controller
and also provides a mechanism for inserting UUID info.
 
 
It also provides a mechanism
for inserting application specific identification into the FC frame.
 
The HBA driver(lpfc) retrieves the UUID when the first IO is initiated
and registers it with the Fabric.
The Fabric assigns an VMID which is unique within the fabric. The
resulting VMID is stored against the UUID/per-port. The VMID is inserted
in all the subsequent FC frames that are originating from the UUID, and
egressing the specific port through which the fabric is connected.
HBA maintains mapping of fabric associated IDs (VMID) to compute associated IDs (UUID).

The HBA changes currently supports only for scsi.
For VM this patch currently supports for
virtio device(device type:Disk Device and BUS type :VIRTIO)


Tests done:
We have tested this patch by attaching the device to
a KVM as a virtio device and added UUID to blkio cgroup as shown below.
 
echo "UUID" >
/sys/fs/cgroup/blkio/machine.slice/machine-qemu\\x2d<ID>\\
x2d<VMNAME>.scope/blkio.app_identifier
 
Then from the guest we run couple of io tests and checked
the VMID are passed to the fabric to identify,monitor the fc frames.

The patches were cut against  5.9/scsi-queue tree


Gaurav Srivastava (15):
  lpfc: vmid: Add the datastructure for supporting VMID in lpfc
  lpfc: vmid: API to check if VMID is enabled.
  lpfc: vmid: Supplementary data structures for vmid
  lpfc: vmid: Forward declarations for APIs
  lpfc: vmid: Add support for vmid in mailbox command
  lpfc: vmid: VMID params initialization
  lpfc: vmid: vmid resource allocation
  lpfc: vmid: cleanup vmid resources
  lpfc: vmid: Implements ELS commands for appid patch
  lpfc: vmid: Functions to manage vmids
  lpfc: vmid: Implements CT commands for appid.
  lpfc: vmid: Appends the vmid in the wqe before sending request
  lpfc: vmid: Timeout implementation for vmid
  lpfc: vmid: Adding qfpa and vmid timeout check in worker thread
  lpfc: vmid: Introducing vmid in io path.

Muneendra (1):
  blkcg:Introduce blkio.app_identifier knob to blkio controller

 block/blk-cgroup.c               |  32 +++
 drivers/scsi/lpfc/lpfc.h         | 122 +++++++++++
 drivers/scsi/lpfc/lpfc_attr.c    |  47 ++++
 drivers/scsi/lpfc/lpfc_crtn.h    |  11 +
 drivers/scsi/lpfc/lpfc_ct.c      | 256 +++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_disc.h    |   1 +
 drivers/scsi/lpfc/lpfc_els.c     | 356 ++++++++++++++++++++++++++++++-
 drivers/scsi/lpfc/lpfc_hbadisc.c | 151 +++++++++++++
 drivers/scsi/lpfc/lpfc_hw.h      | 124 ++++++++++-
 drivers/scsi/lpfc/lpfc_hw4.h     |  12 ++
 drivers/scsi/lpfc/lpfc_init.c    | 108 ++++++++++
 drivers/scsi/lpfc/lpfc_mbox.c    |   6 +
 drivers/scsi/lpfc/lpfc_scsi.c    | 323 ++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_sli.c     |  65 +++++-
 drivers/scsi/lpfc/lpfc_sli.h     |   8 +
 include/linux/blk-cgroup.h       |  19 ++
 16 files changed, 1618 insertions(+), 23 deletions(-)

-- 
2.18.2

