Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47057 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751134AbdARXf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 18:35:57 -0500
From: Song Liu <songliubraving@fb.com>
To: "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
CC: Jens Axboe <axboe@fb.com>, Kernel Team <Kernel-team@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [LSF/MM TOPIC] block level event logging for storage media management
Date: Wed, 18 Jan 2017 23:34:48 +0000
Message-ID: <6040124E-4928-4FC8-8A52-35115D9CA1DF@fb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Media health monitoring is very important for large scale distributed stora=
ge systems.=20
Traditionally, enterprise storage controllers maintain event logs for attac=
hed storage
devices. However, these controller managed logs do not scale well for large=
 scale=20
distributed systems.=20

While designing a more flexible and scalable event logging systems, we thin=
k it is better
to build the log in block layer. Block level event logging covers all major=
 storage media
(SCSI, SATA, NVMe), and thus minimizes redundant work for different protoco=
ls.=20

In this LSF/MM, we would like to discuss the following topics with the comm=
unity:
    1. Mechanism for drivers report events (or errors) to block layer.=20
       Basically, we will need a traceable function for the drivers to repo=
rt errors=20
       (most likely right before calling end_request or bio_endio). =20
 =20
    2. What mechanism (ftrace, BPF, etc.) is mostly preferred for the event=
 logging?

    3. How should we categorize different events?
       Currently, there are existing code that translates ATA error (ata_to=
_sense_error)=20
       and NVMe error (nvme_trans_status_code) to SCSI sense code. So we ca=
n=20
       leverage SCSI Key Code Qualifier for event categorizations.=20

    4. Detailed discussions on data structure for event logging.=20

We will be able to show a prototype implementation during LSF/MM.=20

Thanks,
Song=
