Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A31C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8878760C51
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 12:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKCMQz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhKCMQz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 08:16:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917DC061714;
        Wed,  3 Nov 2021 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JNglMXDv0o4Z85YFuCHofAOWBBagsgZZEOiH7CEQiMY=; b=ZrJ/d170KtEEuGGrm9d9b+zOuE
        jbtC85M1ScAUj9cnNyHIgqqRyrVW9Fx6SVeXt5MPDcC0Ka7i9w21rw+AB6MHqkjwBxNuqC+UCqlIN
        2l6egyIzj6laWYwXT3Y/LcKq8dTBraxWiqJnLTIq62FrA9YmJSUiPoeXqB+tgrK17TMbt6QkU1Lb6
        NdOjt0mb5RNQRDeEX2aQ5sugPoTOGqL72GptYwPOP7fbCwFV9hcxP5TNJl6YLCWoZv2m7bd8sI+Bk
        1JS0eV+dfAgLsb1yFH+5m2O7Bnb8QZpH5lKP/Wyo1xSwf2Jfh8KGsn4vFLCNnn7YZJQTXqF9RWLAV
        g7E5LqOg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miF9m-0055ZW-8p; Wed, 03 Nov 2021 12:14:18 +0000
Date:   Wed, 3 Nov 2021 05:14:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] zram: use ATTRIBUTE_GROUPS
Message-ID: <YYJ9Gks0Rmd2Uepb@bombadil.infradead.org>
References: <20211028203600.2157356-1-mcgrof@kernel.org>
 <520834ee-edd2-282c-017a-b7ed075bd8a0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520834ee-edd2-282c-017a-b7ed075bd8a0@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 28, 2021 at 01:44:38PM -0700, Bart Van Assche wrote:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Just a gentle reminder.

  Luis
