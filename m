Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F4C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 05:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10CE20989
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 05:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D1kLBlyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfCSFOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:14:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38842 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfCSFOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 01:14:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J5ELmT155178;
        Tue, 19 Mar 2019 05:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DwSnNDqnPUTXk4dmngFX+rC699NjHiw/SGofjgeXANc=;
 b=D1kLBlyR1Oc4OaVTPN4eVDW2vXsk7WJKLuZLckfza9YnbOO1GaVpYPMHsvh/rJxj25Hd
 BrIvW2EMaxg5kEFbeRqlI33AhOw/aq4sWC412eXgdDaZq5SBkYtkr/J3fXmb6tbSdEt8
 MHyQn7EHlEzo/AD+HA66xFlvA/itf9WUWTpMoUaqu8pAbx49kfaqVQZlSVIf3cmojx9K
 1c+UG00GHglu16R6OgIZa3vhKSfDIv440Nb4zUaM/pOqdFILktEeOghw6FKEM/fG0aKX
 ULBEqx4kMz7g6zK82Pz3W0auOwEgPwHAQuaMrzrlkYH1oyBSPE2y342Ny+wvFkvLsTsS HQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r8ssra7bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 05:14:28 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2J5EMAP010354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 05:14:22 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2J5EMBp017489;
        Tue, 19 Mar 2019 05:14:22 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 22:14:22 -0700
Subject: Re: [PATCH] sbitmap: order RW on old associated instance and setting
 clear bit
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20190319042447.27580-1-ming.lei@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <9e784c48-2865-a14a-d8f4-e6c74f258f48@oracle.com>
Date:   Tue, 19 Mar 2019 13:17:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319042447.27580-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=904 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190039
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

On 3/19/19 12:24 PM, Ming Lei wrote:
> @@ -591,6 +591,15 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>  void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
>  			 unsigned int cpu)
>  {
> +	/*
> +	 * Once the clear bit is set, it will be visible to allocation
> +	 * side.
> +	 *
> +	 * This memory barrier orders any READ/WRITE on the to-be-freed
> +	 * asssociated instance for avoiding potential use-after-free, and
> +	 * its pair is the memory barrier implied in sbitmap_get().
which one ?

> +	 */
> +	smp_mb();

smp_mb_before_atomic should be enough.

>  	sbitmap_deferred_clear_bit(&sbq->sb, nr);

Thanks
Jianchao
