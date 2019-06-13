Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2129BC31E49
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9FC20B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="GFEWk0im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbfFMPKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:10:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42193 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732313AbfFMNwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 09:52:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so22573987qtk.9
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iBdScbJdiJZd68aym6rhQHLd3tm2EOsfFy62siRg9uo=;
        b=GFEWk0imhVI/2I2j0NZKrJmyS6v/3bvPCAqzum6N/1Q5sr6yUni2cHwAxZONJbnP01
         GMKsKVylo1eVgL2f/W9h6hTULk9/sUBYxVAfbA+oETLxNJYkeDLEDf/f9wQ5X1gc4bKI
         9MLvQ9PmzOHS35R5ynuuFhrpxncsFLKb4qU3eKkn+NTbBFWpzwdEi2WyksuapDegDBoZ
         iG/BQOK9glPcpl1q8cFd5bjCewVt+gkl8RDvf0ost08/NRfLYgJQrqYpB42lD03peNeo
         W6RiBCx9pIogytuJqBNTQ/jEs20p9LKXbZBEUd+EPoq3arEESyOtCyfGd8bZjdsv4kfB
         aVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iBdScbJdiJZd68aym6rhQHLd3tm2EOsfFy62siRg9uo=;
        b=rs4bVzaF7+JCshW+ZX3toEzDDBrIA0a7SnhS5sOMIxzAkP8+BSEe2K2LCnpit8xkre
         hckEeRqy4pxXUVQ5CzOCsTEA3x+OECovaF+IzFcccEZ4OWawy5L7wZFG9rF4sIMMW4gJ
         UhTxLzCHAB9/oR8G7hfFKuJ8RPqYfIsHiX3o96XHWuR505HJ6Lq+DStvNPhNZ8/0MvNZ
         E1g1RKjeb62L8NfsuZK/2KaxMEkPFV6eK3xUcv1NDkZkbDNrBNCs001hmHZbhDO8s/Ux
         dkPozaMrEpQ1uvQQb5xi1K5CtSqydVnHNaUjrOYX4VcearHw0ZjgaHXAifoIinB+HuaW
         dHGQ==
X-Gm-Message-State: APjAAAXLkrox5ioO6P8tdXk419/ybEKhcjs2HgmYe7h9Wn5mKlQdw+zR
        qdnJ2s2igqnVC0esXiwsjImG9w==
X-Google-Smtp-Source: APXvYqzJCWd+rW5ZvwqklVd8I6KrtVVFyDv818dOj3NqIB/npUIpX6o3ODd/u8GDJLhKmzgUZ+Qe3g==
X-Received: by 2002:a0c:af36:: with SMTP id i51mr1935341qvc.128.1560433964768;
        Thu, 13 Jun 2019 06:52:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id e63sm1454584qkd.57.2019.06.13.06.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:52:43 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:52:42 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     roman.stratiienko@globallogic.com
Cc:     linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        nbd@other.debian.org, A.Bulyshchenko@globallogic.com,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
Message-ID: <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612163144.18486-2-roman.stratiienko@globallogic.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 12, 2019 at 07:31:44PM +0300, roman.stratiienko@globallogic.com wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Adding support to nbd to use it as a root device. This code essentially
> provides a minimal nbd-client implementation within the kernel. It opens
> a socket and makes the negotiation with the server. Afterwards it passes
> the socket to the normal nbd-code to handle the connection.
> 
> The arguments for the server are passed via kernel command line.
> The kernel command line has the format
> 'nbdroot=[<SERVER_IP>:]<SERVER_PORT>/<EXPORT_NAME>'.
> SERVER_IP is optional. If it is not available it will use the
> root_server_addr transmitted through DHCP.
> 
> Based on those arguments, the connection to the server is established
> and is connected to the nbd0 device. The rootdevice therefore is
> root=/dev/nbd0.
> 
> Patch was initialy posted by Markus Pargmann <mpa@pengutronix.de>
> and can be found at https://lore.kernel.org/patchwork/patch/532556/
> 
> Change-Id: I78f7313918bf31b9dc01a74a42f0f068bede312c
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> Reviewed-by: Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>

Just throw nbd-client in your initramfs.  Every nbd server has it's own
handshake protocol, embedding one particular servers handshake protocol into the
kernel isn't the answer here.  Thanks,

Josef
