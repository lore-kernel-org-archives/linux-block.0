Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F9BC77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 16:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbjEWQ4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 12:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjEWQ4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 12:56:53 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1161119
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 09:56:02 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6239ab2b8e0so47797826d6.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 09:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860961; x=1687452961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I895gSBgpzDKKLUi/M3iUfQpFGQN//aYkK8LK5AguTA=;
        b=X5k2Z4P/thlsfhvkH73XFJ/Wxe1l4yuY91N34H1QTxXJF+a/nImFQ3aWf4f+cpND/P
         PAlu/tNQzT6JAg1ZESSRY/wAyRNXQEmuqo1DN2myZiVENe73LovNXKAzaQwePUeH6odx
         wuiLO64hkyjmch3l5fx8Y3fHKCcp+4HyTsDG8nTX3kJHkDmEFo6ozOsnA4GeG8njNxMT
         Yz0hF1oStfz7m/emzXUCqTlDMjLyafFx/NsvgzjAp54mOQ131VC98uNkMg1+lYBGK8fY
         Bou6RvPrJiGGlED51Mro7ncqm/4+BbaQy6J1fQNQxQeGQ702B7zvhHuoMCwT76yskc4u
         MtZw==
X-Gm-Message-State: AC+VfDwFzOh7/ORUZor+Gq/bUsbdstw+r9G6hK7uXdiRpEh15yNhlCPD
        +/G0Vpm4FNQtzNjIKgcY5qot
X-Google-Smtp-Source: ACHHUZ7flOXCsLoBxKovnaaX/oi0L/ZSk0yhITAbxyTXaocIhbpqrKl1r3JlMCNYZavegSmc6yz+9Q==
X-Received: by 2002:a05:6214:2aa4:b0:5ef:a772:2731 with SMTP id js4-20020a0562142aa400b005efa7722731mr22618918qvb.11.1684860961501;
        Tue, 23 May 2023 09:56:01 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id cz10-20020a056214088a00b0062120b054easm2895666qvb.20.2023.05.23.09.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:56:01 -0700 (PDT)
Date:   Tue, 23 May 2023 12:56:00 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 17/24] dm-snap: simplify the origin_dev == cow_dev check
 in snapshot_ctr
Message-ID: <ZGzwIGPfRggsU0Ek@redhat.com>
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074535.249802-18-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23 2023 at  3:45P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Use the block_device acquired in dm_get_device for the check instead
> of doing an extra lookup.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
