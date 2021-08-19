Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AEEC4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF0961152
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 13:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhHSNLd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:11:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53556 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231826AbhHSNLd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 09:11:33 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JD3Z9m142273;
        Thu, 19 Aug 2021 09:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=5egLuETDuH4mIhzuJh+/6Ycie5fFKtUxs6bWe30isgA=;
 b=hf/gZEhbA8El1EjwyqJ6qpICwPO8tFr+faEl0klDBU0W4F5m9wkIPRr2tPiY0Ieg/1Oc
 G4Kl8cCAh+8qPuJmMioEEYJlWQLGXq2UBMW9HyoWh/PdKEQwMVj15HxnZGYElHyeR1b7
 VwcS+St1UuBa28GJJCfpfnH6pnOyvhhUru8cTCLRsP2wEMNo4e0zkZldv0FRlj/7Y4hN
 LTkP3EHxvq4xk7EPTyB8dxrohpVMT4pt4JcR3XKg8La7FqSWg92V1CB5HX7NOBpPKZkL
 ia7y3SfSSWiscAYHiMgyUPI29s2kbPpA4Zxb6LCqsUO65GGUBlDlrqKi2Ut30s/iiomb IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahhqkan7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:10:43 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JD49LY145411;
        Thu, 19 Aug 2021 09:10:43 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahhqkan6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:10:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JD1Ixt005663;
        Thu, 19 Aug 2021 13:10:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ae53j0b33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 13:10:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JD75Fg59572718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:07:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CFF74203F;
        Thu, 19 Aug 2021 13:10:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2BAF42049;
        Thu, 19 Aug 2021 13:10:37 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Aug 2021 13:10:37 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in wb_timer_fn
References: <00000000000072e53a05c983ab22@google.com>
        <20210816091041.3313-1-hdanton@sina.com>
        <20210816093336.GA3950@lst.de> <yt9dim01iz69.fsf@linux.ibm.com>
        <20210819090510.GA12194@lst.de>
Date:   Thu, 19 Aug 2021 15:10:37 +0200
In-Reply-To: <20210819090510.GA12194@lst.de> (Christoph Hellwig's message of
        "Thu, 19 Aug 2021 11:05:10 +0200")
Message-ID: <yt9dr1eph96a.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dfLNQNtovBbxNIaVGPzzG_AJkBZsJ0MV
X-Proofpoint-ORIG-GUID: 1EHAt_kdhh9IGDInKJNhKKzK0A_l-eOV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_04:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=730 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190076
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Aug 19, 2021 at 11:03:42AM +0200, Sven Schnelle wrote:
>> I'm seeing a similar crash in our CI:
>
> This series:
>
> https://lore.kernel.org/linux-block/20210816131910.615153-1-hch@lst.de/T/#t
>
> should fi it.  Can you give it a spin?

I tested it without your patchset and it crashed around every second
try. With that patchset, i wasn't able to reproduce it.

Thanks!
Sven
