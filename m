Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A122C61CE4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 17:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E94C2086D
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 17:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfASR3N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:29:13 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:37823 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfASR3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 12:29:13 -0500
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkuQi-0005RI-1s; Sat, 19 Jan 2019 10:29:12 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkuQh-000680-JS; Sat, 19 Jan 2019 10:29:11 -0700
Received: from hacktheplanet (unknown [73.58.156.101])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 15C07211413;
        Sat, 19 Jan 2019 17:29:09 +0000 (UTC)
Date:   Sat, 19 Jan 2019 12:29:02 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, jonathan.derrick@intel.com
Message-ID: <20190119172902.GA14875@hacktheplanet>
References: <1547760716-7304-14-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547760716-7304-14-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gkuQh-000680-JS;;;mid=<20190119172902.GA14875@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v2 13/16] block: sed-opal: check size of shadow mbr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 17, 2019 at 09:31:53PM +0000, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Check whether the shadow mbr does fit in the provided space on the
> target. Also a proper firmware should handle this case and return an
> error we may prevent problems or even damage with crappy firmwares.
> +	len = response_get_u64(&dev->parsed, 4);
> +	if (shadow->offset + shadow->size > len) {
> +		pr_debug("MBR: does not fit in shadow (%llu vs. %llu)\n",
> +			 shadow->offset + shadow->size, len);
> +		return -ENOSPC;
> +	}

Can we please change this check to the following:

if (shadow->size > len || shadow->offset > len - shadow->size)

Thanks

> -- 
> 2.20.1
> 
> 
