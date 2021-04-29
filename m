Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C11C43460
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 16:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF7A61450
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 16:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhD2Qdb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 12:33:31 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:41978 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhD2Qda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 12:33:30 -0400
Received: by mail-pg1-f175.google.com with SMTP id m37so4959345pgb.8
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 09:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=72+Cc6T4xP5R5z04O6kd3PBMqN7qS9j9xNJ870+HsVI=;
        b=o2aqCZJGyfwUqOsno4KGN+H07M/DDVrWZ8KdmYlOD8imVEx0+5tkZuKUeexNh6KQqL
         /WUYuhW0urydaD6ZoCqQSv6+hsYR8M6wmkHbqlf0qP5f7i4+i4bDqYIXEB7zhiLbSnK1
         TBEwLj3QQWyM0u8ABPqVaWmQD9Ah8pYaeOglRhHxUWprCMjjTp9uc2ZLWAurjh66HtQB
         O7Afc166qyhvK8hono0P3ibUUJbPzzQovXRtBcIl1v6LE/cADE8ng7TlMGg0WTeEe1dv
         7rLxYforOoVMjv8AXmTjr+hE/HwWrgzzjjgxXkgeiSvJSdbI77JpyA+1GB/1t6H5TS/q
         CtwA==
X-Gm-Message-State: AOAM533da5dN/vnIrj68hfobdaTwWI/w3urcxCWl4MIwoY54IClu0dp9
        7whvJhNXSSjzqFq13WcN7TU=
X-Google-Smtp-Source: ABdhPJxejEeB2ERB9+lgoeX9VzM1IMRWXXqe79GCx+E0bsl7sn43fSOjlJzAt+ysTY9IIm+cHOEGsg==
X-Received: by 2002:a62:86c3:0:b029:261:5933:e47b with SMTP id x186-20020a6286c30000b02902615933e47bmr826245pfd.34.1619713963758;
        Thu, 29 Apr 2021 09:32:43 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id z13sm390714pgc.60.2021.04.29.09.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 09:32:42 -0700 (PDT)
Subject: Re: [dm-devel] [RFC PATCH v2 2/2] dm: add CONFIG_DM_MULTIPATH_SG_IO -
 failover for SG_IO on dm-multipath
To:     mwilck@suse.com, Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210429155024.4947-1-mwilck@suse.com>
 <20210429155024.4947-3-mwilck@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5d1967f2-8017-c711-dec0-3ffe751974de@acm.org>
Date:   Thu, 29 Apr 2021 09:32:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429155024.4947-3-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/21 8:50 AM, mwilck@suse.com wrote:
> +	if (hdr.dxfer_len > (queue_max_hw_sectors(bdev->bd_disk->queue) << 9))
> +		return -EIO;

How about using SECTOR_SHIFT instead of the number 9?

> +		/*
> +		 * Errors resulting from invalid parameters shouldn't be retried
> +		 * on another path.
> +		 */
> +		switch (rc) {
> +		case -ENOIOCTLCMD:
> +		case -EFAULT:
> +		case -EINVAL:
> +		case -EPERM:
> +			goto out;
> +		default:
> +			break;
> +		}

Will -ENOMEM result in an immediate retry? Is that what's desired?

> +		if (rhdr.info & SG_INFO_CHECK) {
> +			int result;
> +			blk_status_t sts;
> +
> +			__set_status_byte(&result, rhdr.status);
> +			__set_msg_byte(&result, rhdr.msg_status);
> +			__set_host_byte(&result, rhdr.host_status);
> +			__set_driver_byte(&result, rhdr.driver_status);
> +
> +			sts = __scsi_result_to_blk_status(&result, result);
> +			rhdr.host_status = host_byte(result);
> +
> +			/* See if this is a target or path error. */
> +			if (sts == BLK_STS_OK)
> +				rc = 0;
> +			else if (blk_path_error(sts))
> +				rc = -EIO;
> +			else {
> +				rc = blk_status_to_errno(sts);
> +				goto out;
> +			}
> +		}

Will SAM_STAT_CHECK_CONDITION be treated as an I/O error? Is that what's
desired? If not, does that mean that scsi_result_to_blk_status()
shouldn't be used but instead that a custom SCSI result conversion is
needed?

If __scsi_result_to_blk_status() is the right function to call, how
about making that function accept the driver status, host status, msg
and SAM status as four separate arguments such that the __set_*_byte()
calls can be left out?

> +			char *argv[2] = { "fail_path", bdbuf };

Can the above array be declared static?

Thanks,

Bart.
