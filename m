Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCCBC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB572611C1
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKDIvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 04:51:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC15C061714;
        Thu,  4 Nov 2021 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9gP1LH3zvKAxABcAWtH7DhuMpE09FrjJbNcq52Qoyns=; b=VEicMkJmVu4TUtSAdkL2uU9Y1M
        H49HBUXnvi/DvDCoWd2Bd520qo68O1PxCcfwpkPK8V1OZBn3DAMPjLdnNNfzYszLjIIl884Gu65tH
        54kHzCy2KT/2YdrTfGoLtU7i395huQI/fJoyYmvnr1JB11gzEyX++ziBAoulmwMnKmbOIpiT9NB4L
        gOXmYWFIpL6GuLs/y/UG2imcsSste6LVP52vrRWdvjCDWNJZXgGd3kgS9GAByKChjdoO0enzxetoB
        4reePckn/6fVC10fXbfpWTciKYnyD0tnXUEsTi6bLyyI6BMqtkV6s1RQ8Y/G2N7o025+Y4pIKFTyY
        7z8VUWKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYQF-008MKw-9T; Thu, 04 Nov 2021 08:48:35 +0000
Date:   Thu, 4 Nov 2021 01:48:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wu Bo <wubo40@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH RESEND] nbd: code clean for nbd_genl_status()
Message-ID: <YYOeYwPlLnn7JR+W@infradead.org>
References: <1636000703-13217-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636000703-13217-1-git-send-email-wubo40@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 12:38:23PM +0800, Wu Bo wrote:
>  	if (!reply_head) {
> -		nlmsg_free(reply);
>  		goto out;
>  	}

Please also drop the now pointless braces.

>  out:
> +	if (reply)
> +		nlmsg_free(reply);

Please just use a different label for just unlocking vs also freeing
the reply.
