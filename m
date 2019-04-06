Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23E6C10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 09:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692CF21855
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 09:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gIuR+2Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfDFJpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 05:45:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFJpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 05:45:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x369iePW160448;
        Sat, 6 Apr 2019 09:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Q7/Jy+5nqv+682CW6f+P4/yhAa0LRsMlBA/eGg/nXeQ=;
 b=gIuR+2JfzGJWT9656pql7RJ4KoA2YLKuI7RzwAs28e1Fny2waD1DHQqYcFKxSSjb9KS0
 1/PQErMh77LmQgm5plumkriKP6ZJkg/a2UDDTYKXatce+ZM7a9ktxfdBG9h8imYFZH78
 RGCi9gkxWp8iKGtWT0cBglLsaqZQKHubkDbs1Jf8Ts8xCdv2aIn260gR5EPgr3EsOujR
 /HYVpa6sM2i3rm/IG9KePBfEYU8k5whUAZcRdSF5XSyes3YzTcpmVEOKJbnI8FLojS3u
 EupPmzdCyq32Oc4PJ1eLV6OkXUd8wlD7Zw5CZiXjC8UFfTiOKnKysRvqIkZC7nYAqotm hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rpkhsgjx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Apr 2019 09:45:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x369iKmi165298;
        Sat, 6 Apr 2019 09:45:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rph7rcr9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Apr 2019 09:45:02 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x369iwmI013404;
        Sat, 6 Apr 2019 09:44:59 GMT
Received: from [192.168.2.8] (/106.39.150.192) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Sat, 06 Apr 2019 02:44:06 -0700
USER-AGENT: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Message-ID: <398407a1-b270-512a-5894-eebe4c851cc4@oracle.com>
Date:   Sat, 6 Apr 2019 02:44:00 -0700 (PDT)
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     Keith Busch <keith.busch@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
In-Reply-To: <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904060048
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904060048
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04/06/2019 07:36 AM, Keith Busch wrote:
> On Fri, Apr 5, 2019 at 5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
>> Looking at current peak testing, I've got around 1.2% in queue enter
>> and exit. It's definitely not free, hence my question. Probably safe
>> to assume that we'll double that cycle counter, per IO.
> 
> Okay, that's not negligible at all. I don't know of a faster reference
> than the percpu_ref, but that much overhead would have to rule out
> having a per hctx counter.
> 

If there is no faster reference to enable waiting for all inflight requests to
complete, is it possible to re-map (migrate) those requests to other hctx whose
cpus (ctx) are still online, e.g., to extract the bio and re-map those bio to
other ctx (e.g., cpu0)?

One drawback I can see is if 63 out of 64 cpus are suddenly offline, cpu0 would
be stuck.

Dongli Zhang
