Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA9C35254
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 18:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB472082F
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 18:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="qaPz6Gmm";
	dkim=pass (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="mHwqubgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgBJSOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:14:23 -0500
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:56814 "EHLO
        mx0b-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgBJSOW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 13:14:22 -0500
X-Greylist: delayed 752 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 13:14:22 EST
Received: from pps.filterd (m0075028.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AHsCdi013608
        for <linux-block@vger.kernel.org>; Mon, 10 Feb 2020 13:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; h=mime-version : from
 : date : message-id : subject : to : cc : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=Z8dA7ja0z0zhiql1ET4f/eGTFeiCfpiQ/bKG8w6YQ5M=;
 b=qaPz6Gmmr3DEUA5izcCk+LvthhWnEvaFylb5570EhkhpHhvOd/MTtVgx6UmgseW4RLDg
 2a9sMVWOQQebKwGFpEUe8/GJwNwLwoOFGdlgFVtohszdLlwJckltcLnZRaaWz0TYrpOP
 YUoPZRx+n4McnV6+vXG0jXAN/Ksw7ik5kXvxU87ro5CqvozAIZhWE0w+IOBiFoJJwITJ
 4aEukoezTVz5mzoe/mSKRu20Zv9Vqo5hyB3wzUt6BPWGJ9Wi6ngsCwxoOMHtF8jnTVl2
 0QB5c9oqF/K+LQ+2ffeVbv40hta5fixE2uIgTUD+YkQMRBEngeXRRp365w4gc1WKJ/O+ fg== 
Authentication-Results: seagate.com;
        dkim=pass header.d=seagate.com header.s=google
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        by mx0b-00003501.pphosted.com with ESMTP id 2y2avbefdk-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 10 Feb 2020 13:01:49 -0500
Received: by mail-yb1-f200.google.com with SMTP id u5so6370210ybm.7
        for <linux-block@vger.kernel.org>; Mon, 10 Feb 2020 10:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seagate.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Z8dA7ja0z0zhiql1ET4f/eGTFeiCfpiQ/bKG8w6YQ5M=;
        b=mHwqubgw8xQCm4Mbzw4x9eNo+nE33sE0ziwKfcirlJfD1h8txk2ldyLZQbTj+iPgZo
         Yq3NdESdGeYW3g0Ic25cuNvndSsZxpK1p+CRqKUQHguL2iYLXDTp/uNwzWCZYmi9K/ZE
         R+c7GL8l+i4WMjv215RGvupnSeXV8BBAVFECuKS0jIKtzyg3PTqGv0MPfmAEytUSuyGh
         dkeWQwr88DqRgtPFMe/LRhSl6jFNvZ1y/ul+UiuXbfjnYZa4RtlHY9OyYiWnYJQI3AjE
         +bKGvOYe385ehg9wuxAaKe160FRmbXPZOQteEZvrwkkgT+VzoZB2ubQStNoM3kdy9jn9
         iL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Z8dA7ja0z0zhiql1ET4f/eGTFeiCfpiQ/bKG8w6YQ5M=;
        b=oLdFARBTJabDHxaHWD8dueva4m2Q0Zhp4Y2eC6MISe27OZZF2GKxTTtGAycIJ2z4Gd
         pGs9/iWBRUNTkRb/gv3TGtfa2ylsjasedM13uHlukAyj11TugrWEHA0TCaW2NxKR1+5+
         vVW86eXNCh/19N+qr1CXamF147dOv8xtryjEq1I0/cAWAorJNr+IymaHbH/SuR2vU7Ts
         Sq0hf5/eihblpkAq59kW5tehQDRR9QoUZ9nS0S2M8z/E6YH88fB1fJL9UmZE1sUOavg+
         jyp6AYpe/5Djw6DuSdkRhHcEGJNLTgilHVYDvrmNYB5CjFR68z65v+5fK88oT7jnqlj3
         SEjA==
X-Gm-Message-State: APjAAAVtcl2G9G2SyHNK9OySMtr1EWJ/XYoRQmbOa3ic5ObY8Bi4O1kV
        +gL/hw3OkE/qa66Di70Xp047hY7mPkgKmhhsOrGCa/zIdX+YmluSq/tM4vEmQdWCekRnbawlLE+
        qYv10uqKqS3N3T9/Wb2EuYek6+xJf/G58XwsMXJuT8fN44LDAnwsTD2W/edwZwIHY
X-Received: by 2002:a81:b60d:: with SMTP id u13mr1947429ywh.382.1581357709428;
        Mon, 10 Feb 2020 10:01:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzzP96nNZW/MvJzPkPbq/hXLO/p50s4FvrFzDRw94dQxd/SVJksxBedvQtkjNAA42nHDILHHjWS018CvoeJnU=
X-Received: by 2002:a81:b60d:: with SMTP id u13mr1947392ywh.382.1581357708988;
 Mon, 10 Feb 2020 10:01:48 -0800 (PST)
MIME-Version: 1.0
From:   Muhammad Ahmad <muhammad.ahmad@seagate.com>
Date:   Mon, 10 Feb 2020 12:01:13 -0600
Message-ID: <CAPNbX4RxaZLi9F=ShVb85GZo_nMFaMhMuqhK50d5CLaarVDCeg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Multi-actuator HDDs
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     Tim Walker <tim.t.walker@seagate.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=931 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100134
X-Proofpoint-Spam-Policy: Default Domain Policy
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Background:
As the capacity of HDDs increases so is the need to increase
performance to efficiently utilize this increase in capacity. The
current school of thought is to use Multi-Actuators to increase
spinning disk performance. Seagate has already announced it=E2=80=99s SAS
Dual-Lun, Dual-Actuator device. [1]

Discussion Proposal:
What impacts multi-actuator HDDs has on the linux storage stack?

A discussion on the pros & cons of accessing the actuators through a
single combined LUN or multiple individual LUNs? In the single LUN
scenario, how should the device communicate it=E2=80=99s LBA to actuator
mapping? In the case of multi-lun, how should we manage commands that
affect both actuators?

For NVMe HDDs are namespaces the appropriate abstraction of the
multiple actuators?

We would like to share our work mapping LUNs/Actuators through LVM &
MD-RAID to study the performance characteristics and hope to get some
feedback from the community on this approach.

[1] https://www.seagate.com/solutions/mach-2-multi-actuator-hard-drive/
