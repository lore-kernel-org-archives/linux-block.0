Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AA2C54FCC
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35FA2070B
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5rA5yj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUN5h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUN5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 09:57:36 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D31C061A10;
        Tue, 21 Apr 2020 06:57:36 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v10so2466443qvr.2;
        Tue, 21 Apr 2020 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g8sI+x0ifL/wEFiFPpalnoznOyEqF0zjwgw2NNC+4mc=;
        b=o5rA5yj7PKRli/WEwKCwKAqzHohjrHFYqnF5aOaJyw7loMnWOIWACm2qTaSQs7LUeI
         5gJoRqg2exMdQBKvkbyb2/gjHBNwLUb1gI6cbPr9FPPCCZBV4xAiPE5fBow5c+GAaY8N
         KJSh53mCr0DMHmQ0EnIfAumN9vKJBzmcGvG8pcrHUYcicJq5SqyOUCrF5pPcjmn4Lptl
         MlEccAm4LT2dppQdo51o7NJm5XasujoL4CaGuCnwL5QWCFLeuhAtEpR4eMlTrkLSEuJI
         LdoHtDXqd58r51j+H6Eq6OUEHMl4hy/V8Qicr4E+5BxnYC+0lzKwrpFU5f6+m+YSN+iA
         QHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g8sI+x0ifL/wEFiFPpalnoznOyEqF0zjwgw2NNC+4mc=;
        b=SpQPxLZGNhdM1hM95OfWc5Rww2B5bBYaaYj1VSi9lck7j5OQKO2lWyWN84gql7PN7x
         7/9BAfN0ieUIe75UeK6JXBPWAi8+j6VUo/bTd+Adg2o5rt2Y8tdfKFUuUZRZTwUsdriS
         eUzfD8dzRSO8fYOGUtpGgHI2coyCJDksA/UosjmUc1VDT8FVHICJhAan5dZwzrjbbocJ
         1TpfI3hNvJkOnGV30Zp1Tb+gwoc/XSemQNEO5sX+Hae1Hc/N/DgDHpav0idHczln2Njd
         28ni7D1EcXhkNoqDirXabHhufSMdlCpWIyXfppPhShm9Q7wH+E/YHaX8MFCTzObtaErS
         QqHQ==
X-Gm-Message-State: AGi0PuZz7dFykI/6S+U11OtXPq9VJJQXdQ0b+WDf+SXzTAL5nR573Hq3
        LNqQFA2zP42cUdhSce3ejq133S4h3lw=
X-Google-Smtp-Source: APiQypK7FnDixMI3pzcl99s2hbVp+PWT8UxbdsNbkRGLe4Q3ASFN5r2ywfFxMVJjC/xKVGDD5F+B0w==
X-Received: by 2002:a05:6214:28d:: with SMTP id l13mr19522391qvv.181.1587477455411;
        Tue, 21 Apr 2020 06:57:35 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:6809])
        by smtp.gmail.com with ESMTPSA id t67sm1785469qka.17.2020.04.21.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:57:34 -0700 (PDT)
Date:   Tue, 21 Apr 2020 09:57:32 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] loop: Charge i/o to mem and blk cg
Message-ID: <20200421135732.GB9623@dschatzberg-fedora-PC0Y6AEN>
References: <20200420223936.6773-1-schatzberg.dan@gmail.com>
 <20200421033337.13208-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421033337.13208-1-hdanton@sina.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 21, 2020 at 11:33:37AM +0800, Hillf Danton wrote:
> 
> On Mon, 20 Apr 2020 18:39:32 -0400 Dan Schatzberg wrote:
> > 
> > @@ -964,13 +960,16 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
> >  	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
> >  	/*
> >  	 * In the event we cannot allocate a worker, just queue on the
> > -	 * rootcg worker
> > +	 * rootcg worker and issue the I/O as the rootcg
> >  	 */
> > -	if (!worker)
> > +	if (!worker) {
> > +		cmd->blkcg_css = NULL;
> > +		cmd->memcg_css = NULL;
> 
> Dunno if 	css_put(cmd->memcg_css);

Good catch. Need to drop the reference here.
