Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D41C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B01264F8C
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhBCQBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233740AbhBCQBl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 11:01:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A85D64DDB;
        Wed,  3 Feb 2021 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612368061;
        bh=2+q8d6AB+0icLlJqJysUkR43BwnmBlYDmgo6EP8DvMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAkENZAPSiMaW2FnQdsS3bhvmsWdGX8Oa9IfK6cqtoNMt77sl8FV6uY8JSKQn7cIU
         i5fKWf11MBWWVYUcKEEG6hxhh7Zr7Su13yIjO5KGrTLl4jrlKcOG1ZIw1IUWqDQctR
         dPskcuuL++MwK7NkYVDs/fnP8OOavm1txICJoJNY=
Date:   Wed, 3 Feb 2021 17:00:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Damien.LeMoal@wdc.com, snitzer@redhat.com, hare@suse.de,
        ming.lei@redhat.com, agk@redhat.com, corbet@lwn.net,
        axboe@kernel.dk, jack@suse.cz, johannes.thumshirn@wdc.com,
        koct9i@gmail.com, steve@sk2.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavgel.tide@veeam.com
Subject: Re: [PATCH v4 4/6] dm: new ioctl DM_DEV_REMAP_CMD
Message-ID: <YBrIuipGnzmsyKxg@kroah.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
 <1612367638-3794-5-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612367638-3794-5-git-send-email-sergei.shtepa@veeam.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 03, 2021 at 06:53:56PM +0300, Sergei Shtepa wrote:
> --- a/include/uapi/linux/dm-ioctl.h
> +++ b/include/uapi/linux/dm-ioctl.h
> @@ -214,6 +214,15 @@ struct dm_target_msg {
>  	char message[0];
>  };
>  
> +enum {
> +	REMAP_START_CMD = 1,
> +	REMAP_FINISH_CMD,

Don't you need to say what REMAP_FINISH_CMD is explicitly?

> +};
> +
> +struct dm_remap_param {
> +	uint8_t cmd;
> +	uint8_t params[0];

These need to be __u8, "uint8_t" is not a valid type that crosses the
user/kernel boundry.

thanks,

greg k-h
