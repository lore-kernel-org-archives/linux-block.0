Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DAFC35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C152E2467D
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="S65KcoNI";
	dkim=pass (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="Hg/zT6U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgBKTBf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:01:35 -0500
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:49932 "EHLO
        mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731546AbgBKTBe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 14:01:34 -0500
Received: from pps.filterd (m0075555.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BIxULV045270
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 14:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=proofpoint;
 bh=esHMiUeSwXjyvPJP53vh2XpvLViXxDIgD26JWyQ2GCI=;
 b=S65KcoNIMjLVtR98ZVSi94LI5EfSNce0FZsWNFTCN6Zr1uIAfoepw1xTK71Qf1JQu6Mn
 TED7/zXcYcXk6dNiWCJUhEXScOIMyA/d8xvhfBkhAUE6rLSJwylNkrc+fn6FPwyBOwm3
 sxi3UBT4uKK7Npw5JSA9ziMcP/an1GfZHHgUvqSZDrjVKrZ2EbHxcGsefwx2t3nAvs5s
 6RI0f55YYrLUIKE0bz5mo12aFVFi40cD/PI5E3A56ZikYigsgFw86TXBPun1MWWcGP2U
 BQrNZ+2k6ReV30JuMe9EF1vyWeKPZY76zLtRj0UUJPEjg5GnY7EblO6oo2eckrFpMLXq mg== 
Authentication-Results: seagate.com;
        dkim=pass header.d=seagate.com header.s=google
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        by mx0a-00003501.pphosted.com with ESMTP id 2y2ar5v6r7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 14:01:33 -0500
Received: by mail-wm1-f71.google.com with SMTP id m4so1546657wmi.5
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 11:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seagate.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esHMiUeSwXjyvPJP53vh2XpvLViXxDIgD26JWyQ2GCI=;
        b=Hg/zT6U1geDZ1DJi7INZpQOfCx1H1s8YKIjFIYrxBE7U5J1kJ2gS2q93lTfr7Z5TDl
         zhZIGkryOhaj41CMdZmBNT6+mTONSN7nTlKbPJ2iXvru810uG/mxkbAXLrlmN5k33UyY
         oRydwoKwmuYAlXASTvGIQnQqgjn6Y8R2BP0+wcoC6WhzJKyxLiPS1bPKRPzU7+qWeD8b
         eftpNOzX+Z2QFvFj7oKutXcJ1XnCR5F37y/nupXQvQUetUIbeLXsk6ko3PkRhDY4YnKV
         RFRNGnTt70gWI/bVMN59NlMove56w5ThqCVe/JYa5EiqKDK707Dpm72H7sx0bISh9i08
         UEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esHMiUeSwXjyvPJP53vh2XpvLViXxDIgD26JWyQ2GCI=;
        b=mR1e9URw9frixm8Pel/ZVpePeEqyfqe9dUoWNn4aHIml3G1EzExo4sgnjoKzW894Ok
         QTi7GbWAw0h6zMRb6Lu38EQ+MHc13rwCbr1Q7CVxw3IFZeu0IQ0A9dqJIl1yywO6rrBL
         rZZlxr1WMJhT5hOBoZ9+i0IYhbw+cXAmhsoShBU/Qq3KFU4LpPTJp1lZ1RGUa4me05+Y
         2ELGmLS+44oBtWusOvz+9RGzsC5qvSYuqSOF6i424xTzHYbhh8zqr5sxXLuLkApYnDG6
         Lcp9Osrx6jeiixNcP2Bpb8AyxIMjF4gpMN4+ixG55qqApEdmViuGp2v4XJz7bG3Q9AMs
         DHQQ==
X-Gm-Message-State: APjAAAUC5vSnOA9KcR1SqR95Y4WWuxn0h4YuL4d1Zka9L6uKm0Jemz0X
        yTPIh2Sw8uJNvcEiWnGZrLSRV1Mk8LXwl0WabYYdTTX+9yg/ZQw79gFGX+Hkp5X1sKuOqFQOqA4
        GZ7dG751mZPXyZzYBCEN0bPwTm43wziPEytTz+P6W47ENGKKoql5iVCrJNB8hx7cl
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr9882357wrx.218.1581447692158;
        Tue, 11 Feb 2020 11:01:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHfJbVEQUane7A9MspJwRA/aOOQTH6DO+weUnfDXUEjV3EmBBcCyAsrVfB8ClNI3/WlIgji5XI59VpkUPkqmM=
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr9882325wrx.218.1581447691811;
 Tue, 11 Feb 2020 11:01:31 -0800 (PST)
MIME-Version: 1.0
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
In-Reply-To: <20200211122821.GA29811@ming.t460p>
From:   Tim Walker <tim.t.walker@seagate.com>
Date:   Tue, 11 Feb 2020 14:01:18 -0500
Message-ID: <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_05:2020-02-11,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110128
X-Proofpoint-Spam-Policy: Default Domain Policy
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 11, 2020 at 7:28 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Feb 10, 2020 at 02:20:10PM -0500, Tim Walker wrote:
> > Background:
> >
> > NVMe specification has hardened over the decade and now NVMe devices
> > are well integrated into our customers=E2=80=99 systems. As we look for=
ward,
> > moving HDDs to the NVMe command set eliminates the SAS IOC and driver
> > stack, consolidating on a single access method for rotational and
> > static storage technologies. PCIe-NVMe offers near-SATA interface
> > costs, features and performance suitable for high-cap HDDs, and
> > optimal interoperability for storage automation, tiering, and
> > management. We will share some early conceptual results and proposed
> > salient design goals and challenges surrounding an NVMe HDD.
>
> HDD. performance is very sensitive to IO order. Could you provide some
> background info about NVMe HDD? Such as:
>
> - number of hw queues
> - hw queue depth
> - will NVMe sort/merge IO among all SQs or not?
>
> >
> >
> > Discussion Proposal:
> >
> > We=E2=80=99d like to share our views and solicit input on:
> >
> > -What Linux storage stack assumptions do we need to be aware of as we
> > develop these devices with drastically different performance
> > characteristics than traditional NAND? For example, what schedular or
> > device driver level changes will be needed to integrate NVMe HDDs?
>
> IO merge is often important for HDD. IO merge is usually triggered when
> .queue_rq() returns STS_RESOURCE, so far this condition won't be
> triggered for NVMe SSD.
>
> Also blk-mq kills BDI queue congestion and ioc batching, and causes
> writeback performance regression[1][2].
>
> What I am thinking is that if we need to switch to use independent IO
> path for handling SSD and HDD. IO, given the two mediums are so
> different from performance viewpoint.
>
> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_linux-2Dscsi_Pine.LNX.4.44L0.1909181213141.1507-2D100000-40iolanthe.rowla=
nd.org_&d=3DDwIFaQ&c=3DIGDlg0lD0b-nebmJJ0Kp8A&r=3DNW1X0yRHNNEluZ8sOGXBxCbQJ=
ZPWcIkPT0Uy3ynVsFU&m=3DpSnHpt_uQQ73JV4VIQg1C_PVAcLvqBBtmyxQHwWjGSM&s=3DtsnF=
P8bQIAq7G66B75LTe3vo4K14HbL9JJKsxl_LPAw&e=3D
> [2] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_linux-2Dscsi_20191226083706.GA17974-40ming.t460p_&d=3DDwIFaQ&c=3DIGDlg0lD=
0b-nebmJJ0Kp8A&r=3DNW1X0yRHNNEluZ8sOGXBxCbQJZPWcIkPT0Uy3ynVsFU&m=3DpSnHpt_u=
QQ73JV4VIQg1C_PVAcLvqBBtmyxQHwWjGSM&s=3DGJwSxXtc_qZHKnrTqSbytUjuRrrQgZpvV3b=
xZYFDHe4&e=3D
>
>
> Thanks,
> Ming
>

I would expect the drive would support a reasonable number of queues
and a relatively deep queue depth, more in line with NVMe practices
than SAS HDD's typical 128. But it probably doesn't make sense to
queue up thousands of commands on something as slow as an HDD, and
many customers keep queues < 32 for latency management.

Merge and elevator are important to HDD performance. I don't believe
NVMe should attempt to merge/sort across SQs. Can NVMe merge/sort
within a SQ without driving large differences between SSD & HDD data
paths?

Thanks,
-Tim

--=20
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
