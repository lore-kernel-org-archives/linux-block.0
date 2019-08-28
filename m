Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7FFC3A5A6
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E729123404
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567004703;
	bh=Y0FrmRAFdeRhk4l0qpDc8UrGwdpgR2a3BWwLNc900ik=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=XB4L3E5QrgqB8SqGQB+FwhVLhfPuvliDmg6TwTdwU+EXgMXnpgpc/2jaA9eoqW9DJ
	 fRe9eP5EdTrqlst8l3s0ZG1oEF54D4WOO2yhPHzqj4M1hJfaBz8dFGNywquqzQRfo/
	 CyWBQxdXc/NJl9obFgRtpzvpyrO4W7d8Oo8jdUcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfH1PFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfH1PFC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Aug 2019 11:05:02 -0400
Received: from localhost (unknown [40.117.208.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DDF2189D;
        Wed, 28 Aug 2019 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567004701;
        bh=Y0FrmRAFdeRhk4l0qpDc8UrGwdpgR2a3BWwLNc900ik=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
        b=RHVJ8yFy+XCAGSvrRy9AUbC6iHpiKGnd6XW/IuGERS/7qe445U0e1EuDEEvaNrfTC
         aWhYp6hGA5C/mPDH0B3psUZMDK6nOPxT4PanOTsvySUeR0f1HMC7ccc0FlhAASiKHT
         aNrGaNRKBRWHSAIDk9UPRnc4qVAFclKXq4xiqd7o=
Date:   Wed, 28 Aug 2019 15:04:59 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>
Cc:     stable@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] block: mq-deadline: Fix queue restart handling
In-Reply-To: <20190828044020.23915-1-damien.lemoal@wdc.com>
References: <20190828044020.23915-1-damien.lemoal@wdc.com>
Message-Id: <20190828150500.D5DDF2189D@mail.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 7211aef86f79 block: mq-deadline: Fix write completion handling.

The bot has tested the following trees: v5.2.10, v4.19.68.

v5.2.10: Build OK!
v4.19.68: Build failed! Errors:
    block/mq-deadline.c:571:39: error: ‘struct request’ has no member named ‘mq_hctx’; did you mean ‘mq_ctx’?


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

--
Thanks,
Sasha
