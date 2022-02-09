Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F63C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 21:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiBIVwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:52:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiBIVwA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 16:52:00 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1EDF49885
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 13:52:01 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id n6so2997918qvk.13
        for <linux-block@vger.kernel.org>; Wed, 09 Feb 2022 13:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=+KQV3KMSnnUOCfI2fkELTlqbV6pIH87B8EpZ9AiDcXo=;
        b=qy+icEr6KJhCohC425kW8gmaTjZ0ATgSiQzfjVUzvB+4E92YSb7gqUYEuvdO0gtGYU
         nW19DPlzilGzji2/wTnVu65KrVpJ2euZHOAjp9Nxt1SaF14HrYA9C+juWI9q24b58osU
         MFBGthlpfbNIHYx7T6j3DW14SR4CB70E+1KGNU7bvpxA4jU+aI6M2HWRmqO96YQ7f49P
         KadBoUIFca7+RRqrEZnKkYS3WXNaPpLHyDSO2/dKNa+j+pGOnx8BcxEknDdaj5sWFvGx
         dh02QQiJ9+vWbCgA4YBwucly5EAlArMQbLy4t+xybnSNC/PF8dGukX0WuR8WGvQL0ZfB
         aoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=+KQV3KMSnnUOCfI2fkELTlqbV6pIH87B8EpZ9AiDcXo=;
        b=35GQiQQKmEy6Xp02/5xYJPz5NaepndqcbgEh/BSEphPyLMMIeCarXasXtLLHRVCsAE
         D9Ds7ZSLeqO/k0Bch/PuAoCJdabGPbaVFhwtnlEL01oIbwAexDLcWn5hdurbaYJ+EOyF
         z3BshruTcbPDoHbFQyFmFiAA+sZLA0B5mQ8sJsXB0arKqgR1TXIpiVa0sO6QZXSWJ1Uh
         pFkHlmsrh1E9O1+GF5yB/qkckqhbjrBCgucSJrV8rbid/Eybpwac/xD+TjbY4lAARmpk
         O3btp4YVoNog84EWtbSZAZJsNppJAlqtidg8W3vFpnUeJBgC97eBJ31tMnxSaMlm3v7n
         CFyw==
X-Gm-Message-State: AOAM533uFJAmB288CfH8r2WR0wnpI5DGCbtQly96VtRXVCb9Ovf8Nnmr
        YcUlrbsxgI6t1E/69nEG17bq1g==
X-Google-Smtp-Source: ABdhPJyoMbI85IYVAWwegUJeGiQZ8AcYZmQuxyLdjq00t9sKA24p2TopQ232ctEQFtAHwVPwXJRPeg==
X-Received: by 2002:a05:6214:2306:: with SMTP id gc6mr3009292qvb.131.1644443520168;
        Wed, 09 Feb 2022 13:52:00 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:42f0:6600:cd8a:8634:7b18:da1e])
        by smtp.gmail.com with ESMTPSA id bl1sm8887446qkb.16.2022.02.09.13.51.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 13:51:59 -0800 (PST)
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: [LSF/MM/BPF TOPIC] File system techniques for computational storage
 and heterogeneous memory pool
Message-Id: <E0E49215-1C61-48ED-8A89-889C2E65A53B@bytedance.com>
Date:   Wed, 9 Feb 2022 13:51:57 -0800
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Cong Wang <cong.wang@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I would like to discuss potential file system techniques that could =
employ the computational storage=E2=80=99s capabilities and how =
computational storage would collaborate with the file system. File =
system plays the role of mediator between application and storage device =
by means of creating the file/folder abstraction. So, the file system =
still is capable of creating a good abstraction for the case of a =
computational storage device. What could such an abstraction look like? =
The responsibility of the file system would be to offload (send an =
algorithm on storage device side) or to initiate the existing algorithm =
execution on storage device side.

If we consider any algorithm then, usually, an algorithm is a sequence =
of actions that needs to be applied to some set of items or objects of =
some type. So, it is possible to see the necessity to consider: (1) data =
object, (2) algorithm object, (3) object type. Data and algorithm =
objects can still be represented by files. However, there is a tricky =
point of sharing file system knowledge about file=E2=80=99s content =
placement with computational storage. So, finally, what could be a basic =
item to represent an object inside of computational storage? Would it =
be: (1) logical block (LBA), (2) LBA range, (3) stream managed by =
storage device, (4) file system=E2=80=99s allocation group, (5) =
segment/zone? Technically, a folder could still be a namespace that =
groups a set of objects. And algorithm object can be applied by =
computational storage on a folder (set of objects) or file (one object). =
Or, maybe, a file/stream needs to be considered like a set of items?

The next question is when an algorithm execution can be initiated? One =
of the possible way is to execute such an algorithm at the moment of =
delivering the code from the host on the storage device side (eBPF =
way?). However, if the code is already inside of computational storage =
then a trigger model can be used (when some event could initiate the =
code execution). So, the file system could play the role of algorithm =
execution initiator and to define objects that should be processed. The =
trigger model implies that computational storage could register an =
action (algorithm) needed to apply on some object or data type in the =
case of an event. What potential events can be considered: (1) read =
operation, (2) write operation, (3) update operation, (4) GC operation, =
(5) copy operation, (6) metadata operation, and so on?

What potential mechanisms of function/algorithm delivering in =
computational storage? It is possible to consider: (1) SCSI/NVMe packet, =
(2) file/folder extended attribute, (3) DMA exchange, (4) special =
partition.

Any opinions, ideas?

Thanks,
Slava.

