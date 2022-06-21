Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DFDC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 08:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347948AbiFUIBY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbiFUIBY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 04:01:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E28218E1D
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 01:01:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C41FD21EA1;
        Tue, 21 Jun 2022 08:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655798481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWWZU/9RTk0DKI5k8sAtmFDXpop1CG6B97P9TgLHjXI=;
        b=WuzAM3o/E02rPyO9lIcUSepZF6n9rGN6EFgCaDapmWFQAGKJcwv1BpWqCBe+vgwn7URsEF
        MgUL/UxHYCOkjZpBHQFi9Ht6T3NVrFXqx1KV0N+VHYyxHFaHCl7yAf8Q6LcX2Ej2uOVKis
        zrHfom9dtmo4gJdjaOsuQLDOhophEwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655798481;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWWZU/9RTk0DKI5k8sAtmFDXpop1CG6B97P9TgLHjXI=;
        b=4cDoeOtA1CmzQOWJ0tvS9HMlAGo/ZWYOYpIMEAlpYreQyTi9F1CAKViYwfnhl30a5ARB19
        sOzo8SJ3ql2OPcCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 529FD2C141;
        Tue, 21 Jun 2022 08:01:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B6504A062B; Tue, 21 Jun 2022 10:01:17 +0200 (CEST)
Date:   Tue, 21 Jun 2022 10:01:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 3/8] block: Make ioprio_best() static
Message-ID: <20220621080117.zhnw25ny3jmmxotc@quack3.lan>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-3-jack@suse.cz>
 <c060f9ac-90b6-3aac-e09f-9e7c99f364aa@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c060f9ac-90b6-3aac-e09f-9e7c99f364aa@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 21-06-22 08:47:29, Damien Le Moal wrote:
> > diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> > index 61ed6bb4998e..519d51fc8902 100644
> > --- a/include/linux/ioprio.h
> > +++ b/include/linux/ioprio.h
> > @@ -66,11 +66,6 @@ static inline int get_current_ioprio(void)
> >  	return prio;
> >  }
> >  
> > -/*
> > - * For inheritance, return the highest of the two given priorities
> > - */
> 
> Nit: you could move this comment over the static function. But the name
> makes it fairly obvious what it does :)

Yeah, I didn't find it particularly useful, especially after ioprio_best()
becomes pure min() so I've just deleted it...

> > -extern int ioprio_best(unsigned short aprio, unsigned short bprio);
> > -
> >  extern int set_task_ioprio(struct task_struct *task, int ioprio);
> >  
> >  #ifdef CONFIG_BLOCK
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
