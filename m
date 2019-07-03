Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA86C5B578
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2AF21897
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1A9AYBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGCHRl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:17:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35311 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGCHRl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 03:17:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so783410pfd.2
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2019 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iisGLnpDMCDcRGYnZFrm5QNOBopjV0PFBP/WVXC7UXs=;
        b=G1A9AYBKheMdFrnvN1YyO1MJLGjXEDLlSzS7pWcdPzD8H3eDh9cX1ySjCHXjZSiGQl
         znxHfP4GxqdPDd+d/tsGHq5GaPoiegA+hQU9sBBTXJqA510+yr7UsxW70ghiXYMvEgxh
         1wnvoGFinNBNQfPzDnZW+yzYO6UBWF5YEEDxEE8UzxF0GG6oqPPOKiMdD51EzWGBWMpY
         /2DEz40WGLLb6JFmUYip8R9rp0U2LQF/x8KNCOh9D5HglfIItrkyj1o4p/j3XDZdbDnU
         jxeaDnXhltcEsiXt7LXVFYVrF7bQNMR7EGCF2CPpY03iRmvxMbsT/y9SufbVFVsWFO5v
         TYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iisGLnpDMCDcRGYnZFrm5QNOBopjV0PFBP/WVXC7UXs=;
        b=m9Eq88r/sRdNqfhJ9Z//WBIT7VUfce670D2zV4NtmO2rz5WmNsVVDjVprjf8p1+HQZ
         VQYM7u8rtTiimylgjZnhx9Ru1udy9tC4QCXUAxhUj6OVSFZGijepANW9cSE6MpDediYi
         dDl3Luq0LEeoKC40YA2wPfCeTT62bvLJo2tw7bsdYDyuCYC+ipTuuie2rKbHbgtUDC14
         zv9Cdj5XnDP3qOdcIy0QD7Dft28oVnJ3IyuHENSou5uwyP0ci/htb7DLt/RZzdGboPfe
         SA+JIFUl7gJXQ+/k5XBJG7iVKtMSyqj4IUUmhuYCBOj9i6P8huyK5lw0U5lvu4yjNUpl
         PcFg==
X-Gm-Message-State: APjAAAXzq+d16nbUUV85Fq9TIWZQCOCec8a/l++9hDQMEqbAsDRytQZM
        Mt8xKPSJmAlCFKp+02YQJ84=
X-Google-Smtp-Source: APXvYqxNMAsx58gkg+4a+u9KFhWHrEfwfu6HTSLrngVE9uUwVIVHTcYsa7TsuZwpHGst59l40NvRXw==
X-Received: by 2002:a65:62c2:: with SMTP id m2mr35932735pgv.413.1562138260273;
        Wed, 03 Jul 2019 00:17:40 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id f19sm1663392pfk.180.2019.07.03.00.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 00:17:39 -0700 (PDT)
Date:   Wed, 3 Jul 2019 16:17:37 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] null_blk: add unlikely for REQ_OP_DISACRD handling
Message-ID: <20190703071737.GD21258@minwoo-desktop>
References: <20190702032027.24066-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190702032027.24066-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-01 20:20:27, Chaitanya Kulkarni wrote:
> Since discard requests are not as common as read and write requests
> mark REQ_OP_DISCARD condition unlikely in the null_handle_rq() and
> null_handle_bio().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Chaitanya,

Just a simple doubt here.  I just have tested this patch with 'dd' to
see any performance benefit when queue_mode == 0 || 1.  But I don't
think it's worth it for the performance of read/write OR I have an wrong
way to test it.  you have never mentioned performance in this patch,
though.

But, I do like this patch because it will indicate what you have
mentioned in the commit message in the code level.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks!
