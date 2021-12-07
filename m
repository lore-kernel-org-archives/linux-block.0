Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14BDC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 13:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhLGNok (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:44:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232672AbhLGNoj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Dec 2021 08:44:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7BoTp7015816;
        Tue, 7 Dec 2021 13:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=OU67932s9nPXbInNV9ogc8XM5cXxloEWToSoDXNc828=;
 b=KONEItXu11n5n8/pFOihjGDyJXOCKovdYRzP867i440qiVpfxozs8bZLzgfH4yESt5+z
 jeADFM917CX5lqETNrsIL5aqTtDnSmXfqZVd2xKRPoVG8h4pzCbD0afldJqoMzhl0wXR
 tVm55SYK2VVj2AnowYG1iAv0CQgkx+czQtCdk+wUaPLk8Ddssl9RrSNWudg1grseHXED
 +o4kGBElTUmg7uHrxxBkqnK5ecPPKDaSTibyFqnmE+/s0qQT5jGaCLSmZifVrL98UqkN
 dyuX3VvPkQbBACIbedBMjUiBxsjWBOjn7fvFEWNDwVc6BBi7onN+698Ua3W9W0wtSVHt zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct4e45qqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 13:41:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7DSSLd022346;
        Tue, 7 Dec 2021 13:41:07 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct4e45qpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 13:41:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7DXAq5022137;
        Tue, 7 Dec 2021 13:41:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3cqyyaptrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 13:41:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7DXLdc25755974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 13:33:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D9BD42041;
        Tue,  7 Dec 2021 13:41:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB48842045;
        Tue,  7 Dec 2021 13:41:01 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.49.113])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  7 Dec 2021 13:41:01 +0000 (GMT)
Date:   Tue, 7 Dec 2021 14:40:59 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Changhui Zhong <czhong@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        skt-results-master@redhat.com, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [bug report][bisected] WARNING: CPU: 4 PID: 10482 at
 block/mq-deadline.c:597 dd_exit_sched+0x198/0x1d0'
Message-ID: <20211207144059.679de0b1.pasic@linux.ibm.com>
In-Reply-To: <CAHj4cs96tX1ozhw5tKC-3XrFvOtSvPPNjMsi=C3Q05uvxCvAnw@mail.gmail.com>
References: <20211207104000.1360015-1-pasic@linux.ibm.com>
        <CAHj4cs96tX1ozhw5tKC-3XrFvOtSvPPNjMsi=C3Q05uvxCvAnw@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ug986Gnl2Faf0IVctDA1XDNwX0AAacEz
X-Proofpoint-GUID: _nIZf_-DQ_I7WJYBUUsbGCJtsrthGa0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070081
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 7 Dec 2021 19:14:23 +0800
Yi Zhang <yi.zhang@redhat.com> wrote:

> > What is the status of this?  
> 
> Hi Halil
> This issue should be already fixed, here is the commit:
> 
> commit 2b504bd4841bccbf3eb83c1fec229b65956ad8ad (tag: block-5.16-2021-11-19)

Thank you very much! We haven't seen this in a while, and it is very
likely that this commit indeed fixes our symptoms as well! I didn't find
it because I looked for 'Fixes: e0d78afeb8d1', sorry :D

Have a great day!
