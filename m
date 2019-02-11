Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E807C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 10:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D567320821
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfBKKb4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:31:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:35286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfBKKb4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 05:31:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C349AFAE;
        Mon, 11 Feb 2019 10:31:55 +0000 (UTC)
Date:   Mon, 11 Feb 2019 11:31:54 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Aleksei Zakharov <zakharov.a.g@yandex.ru>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid setting wbt_lat_usec to current value
Message-ID: <20190211103154.GB7427@linux-x5ow.site>
References: <1549879834-24837-1-git-send-email-zakharov.a.g@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549879834-24837-1-git-send-email-zakharov.a.g@yandex.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
