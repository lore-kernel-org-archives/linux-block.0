Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BCFC352A4
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 03:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1339D20724
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 03:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="sT7GX9hW";
	dkim=pass (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="UwSOsUEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgBMDNR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:13:17 -0500
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:58992 "EHLO
        mx0a-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729378AbgBMDNR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 22:13:17 -0500
Received: from pps.filterd (m0075552.ppops.net [127.0.0.1])
        by mx0a-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D3DAow040742
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 22:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=proofpoint;
 bh=aeRDRytmjUxMR4R/7zSm4XSSyOBaq5LlOPitnTdrdUc=;
 b=sT7GX9hWtVbvQllqQGubfW4gpVrtrI4b0mVJDQpJk5BvSOUjyCfKxe8Q6MmV5mCSGVY7
 0q1VWqBuBWHCT8jY+nPMy/0AfVQw60DqaEjVzNUXMjyl54tVEIKcvOQbP4DGRlPDhbdJ
 H5xAP8jmzQft/7AHlLSKQTZjgCB6YLY6U3Ntn2SUr+/JIqsW22HWOHr4Fs9tq1L/eDp0
 AQ9YYeEZDV8ZXIuEm8q+8dv3jLJvP2cccB1S6xCsaRRNc7lOuHd5aAWyYmdqpVW7I/CZ
 th8+9z8HccpvLBGfFzL1H9TPEC647ullpsWpiXuFT1lUKIcJbRuG9RLaEy+nFGjPqX98 tg== 
Authentication-Results: seagate.com;
        dkim=pass header.d=seagate.com header.s=google
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        by mx0a-00003501.pphosted.com with ESMTP id 2y2b9gbhrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 22:13:13 -0500
Received: by mail-wm1-f69.google.com with SMTP id b133so1768672wmb.2
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 19:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seagate.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeRDRytmjUxMR4R/7zSm4XSSyOBaq5LlOPitnTdrdUc=;
        b=UwSOsUExMjS/94lWRUhTH9yzR2CUuf4WjA7nIIQcNPWQ85Ag3w775ibW95ngKz3FO9
         1VysFDpCmNOzW9KbOw4cTaf5RsPVmnqic+UDWofY+6OyFw3VZv1XFZX7fe4IsD1VTG9S
         bhjh0n9BTNhfu9r1cEpO1DgJYWiuJ0I6BEYZkigkc7z9AcwMimISNs5X7woby/Vt1yKR
         0LIKD5U3oxAmxfgOUXz+qhHp3cqM3vsxxso6Gn00YFRVDAnVxMEoJr6/aKeIut9gPTYp
         KFoFvLTbyHs8G+Kibh4Ytj0GRvLxO8ncJcIsj5xXjJtsihdVxvwdquyCP5EzdzxxVOpq
         ib/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeRDRytmjUxMR4R/7zSm4XSSyOBaq5LlOPitnTdrdUc=;
        b=owkXRmE3dxgFJfhJAgSyOCabtNw9T1bnWjFuhYHpPlqhrP0ZL22Z7Vr/ztm45vH8bV
         ad63zQTvqpox0A7yohQUJFZLOxY/E9LqXTwVAEiFLdLcsToHeH2AvAr9pWwyKDUY3BBj
         RPADprJUGYehJGa56J9E4vDT7/6pjkrnsuZOoS3KhGzduxIEEqOn0Sf2FlHkZbnQg0Bz
         YYqLjR18+V/LhXSv+U20bRZltnkEWFhOFLN+HynjLJR53hP9YXXGxOSIBzsuSwLkkN0g
         +cSj4+oT0BfN/SuGlwvijO738HGaabMSLgl9Ipoe9zgrzKCIQVjqsTFkFhON2y/wv2MD
         KjfQ==
X-Gm-Message-State: APjAAAWGhYUlszoNZ83XwyjN4hlOAVF9s50N0KIGtfuj8tm1C6FP+ecT
        jBDtvjj/iV1Uimm2R5CuQqtd/nNUH2fnixUSO0cIOs5kkIU/lTPya/Pj5ixE/TRJM5OUs495AjD
        ycC1QfRHcM8oEYtx7rfwevnC59k68dwMCc3zxf5jbUkchlzt2Of1zQ562DMIY3CF7
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr2718844wma.111.1581563580562;
        Wed, 12 Feb 2020 19:13:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqybjxFdSjprgwYZrF75D1xoH7KGu1PhRJqaE7+0aWDRg5D8u6mQWhAEWh3emC6n7MbmGjAh0f9wt+SbTn5te2g=
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr2718799wma.111.1581563580199;
 Wed, 12 Feb 2020 19:13:00 -0800 (PST)
MIME-Version: 1.0
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p> <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
In-Reply-To: <yq1blq3rxzj.fsf@oracle.com>
From:   Tim Walker <tim.t.walker@seagate.com>
Date:   Wed, 12 Feb 2020 22:12:48 -0500
Message-ID: <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_10:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=1
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130024
X-Proofpoint-Spam-Policy: Default Domain Policy
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 10:02 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Damien,
>
> > Exposing an HDD through multiple-queues each with a high queue depth
> > is simply asking for troubles. Commands will end up spending so much
> > time sitting in the queues that they will timeout.
>
> Yep!
>
> > This can already be observed with the smartpqi SAS HBA which exposes
> > single drives as multiqueue block devices with high queue depth.
> > Exercising these drives heavily leads to thousands of commands being
> > queued and to timeouts. It is fairly easy to trigger this without a
> > manual change to the QD. This is on my to-do list of fixes for some
> > time now (lacking time to do it).
>
> Controllers that queue internally are very susceptible to application or
> filesystem timeouts when drives are struggling to keep up.
>
> > NVMe HDDs need to have an interface setup that match their speed, that
> > is, something like a SAS interface: *single* queue pair with a max QD
> > of 256 or less depending on what the drive can take. Their is no
> > TASK_SET_FULL notification on NVMe, so throttling has to come from the
> > max QD of the SQ, which the drive will advertise to the host.
>
> At the very minimum we'll need low queue depths. But I have my doubts
> whether we can make this work well enough without some kind of TASK SET
> FULL style AER to throttle the I/O.
>
> > NVMe specs will need an update to have a "NONROT" (non-rotational) bit in
> > the identify data for all this to fit well in the current stack.
>
> Absolutely.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
Hi all-

We already anticipated the need for the "spinning rust" bit, so it is
already in place (on paper, at least).

SAS currently supports QD256, but the general consensus is that most
customers don't run anywhere near that deep. Does it help the system
for the HD to report a limited (256) max queue depth, or is it really
up to the system to decide many commands to queue?

Regarding number of SQ pairs, I think HDD would function well with
only one. Some thoughts on why we would want >1:
-A priority-based SQ servicing algorithm that would permit
low-priority commands to be queued in a dedicated SQ.
-The host may want an SQ per actuator for multi-actuator devices.
There may be others that I haven't thought of, but you get the idea.
At any rate, the drive can support as many queue-pairs as it wants to
- we can use as few as makes sense.

Since NVMe doesn't guarantee command execution order, it seems the
zoned block version of an NVME HDD would need to support zone append.
Do you agree?

-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
