Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B501AC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E0F206E0
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGNbo7nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFZUmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:42:04 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:36791 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZUmD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:42:03 -0400
Received: by mail-pl1-f180.google.com with SMTP id k8so2072528plt.3
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S31JEDcLBxkf0+0leLRLwyNs8ezZI6yEuqCuLmcdqjU=;
        b=WGNbo7nr+o1TXXP5NvoL8d1xfW6iRK8FDoYpkssjsC1DPz+4SUNmWRHL8anfzfyque
         8N9iUtuDZRtKsR4iIOlSukaDDpqn6dmybKdo8PW1evX6NvBfugKkxZSvP8w18dZBEucy
         kqcHnyooY69wltjzKemz+lQLvasfhkb12BdtQemnquQR2na+JErjOwv0o1UpENMKdJX3
         NKCHhI/31vICZdZgX/zq/TSGOj/PEGEGDhUVgo1L0tMUHyIDsKE+1RbHRR1cXjNONyAO
         E5n2ymER0JSYUzcZxM9ZQfUO3QVpTcTmSZj+h43WCtn9ikPZoyyljTOrdu9EJUcDWvvY
         i7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S31JEDcLBxkf0+0leLRLwyNs8ezZI6yEuqCuLmcdqjU=;
        b=EaxSZd9srFQ5vhwnzrpg4sIDN+lfpgqSc74gXAADzF46oWChN+3sW2dNt85JDj/Zl9
         9a15gFVotfj7jCSVZJIxt00aX8sT82bb/EQvEzKZ1XeKawSo0EyoQVPj5H14035Z2fg/
         +OKwwkQAOO/0D545n7nd3dlwdf4YEM8zyHzqcuWTQohFO15SP5pegP4FTdr2j4JyTVDM
         ROscPFyYXX0IEQAGJaObfl+avP6uwieaPJg8BEwk15hNbVk5gydJQB5INQ6NGnXtaaC+
         s9VM3xEshfp4Bu/BNtU2mfYu2EqI2VYooU85gvY9jlK+5M/e1MphQ3aSENJcu7suuAm1
         ktyQ==
X-Gm-Message-State: APjAAAVRgtXIWzIv6/Pv89q4oMIzYy0kDRNk1dFzq7PTDkrzHM2i3nBZ
        DvwotBYbKUm1mZYqbgDyTZgabwoij7Q=
X-Google-Smtp-Source: APXvYqxWZMAGs+Wu+GkSSeD4TPBF+NBjbXVh9N9aAqasDfi2DmYGFOjsmn42EJaIwc8kV+zZ8OtIKQ==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr29154plp.71.1561581723179;
        Wed, 26 Jun 2019 13:42:03 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id c130sm94948pfc.184.2019.06.26.13.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:42:02 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:42:00 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 5/9] iomap: use bio_release_pages in iomap_dio_bio_end_io
Message-ID: <20190626204200.GF4934@minwooim-desktop>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626134928.7988-6-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
