Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BB4C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Jun 2022 18:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiFISQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jun 2022 14:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFISQP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 14:16:15 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA9E4B15
        for <linux-block@vger.kernel.org>; Thu,  9 Jun 2022 11:16:13 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id hh4so17733637qtb.10
        for <linux-block@vger.kernel.org>; Thu, 09 Jun 2022 11:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IqBa9uKPuzMBYw7EO8+JYWz3LeyC2Z89LKKu3TPj9R0=;
        b=Vp7TGIrFglsiVwALJZTZqyHHC7QffJwSgLv7ph8NohX25F2AnT8rIStVqrgjEsfH0F
         LeR6X1TiQBO8GcqD42Xbd9Md7OCuZ4cfUPoTc+xHfsR2BS725yAr/LXSRjRBnZtqgOFi
         FIq1ICv+z16RytBv48whWw0w7d1Nm0o5kXDoDpyhWO44qJESNly2XPoZvUQMhUzmSU3H
         4FG0sZGje0UgLLs8P+SegEzGjTxZq7/BZPWUEw/SupKZb3XTLDn00QOCSzo6gt4mjpCF
         a5e3kLNG9pcZyqvP2LOK0wAcI0DcuYjRvPdTnIdJmnYDTsbwavELLZMm7CpwL92C9Jgc
         0Isw==
X-Gm-Message-State: AOAM533FStf/G0pkkh/9lDVmgsUK4ednWcUN0YYGYdAoUPphcP+u9+tv
        p292RK+9VKoXk9yMCsH8STPW
X-Google-Smtp-Source: ABdhPJytzPNfgq8ZJoYGppEW1woIaioYo1mXF5NBN1eY+hf5YvYEfiA0kUdl0ynUP975PfILGVrNaA==
X-Received: by 2002:a05:622a:47:b0:305:1ab:e52d with SMTP id y7-20020a05622a004700b0030501abe52dmr7932244qtw.688.1654798572745;
        Thu, 09 Jun 2022 11:16:12 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006a6c230f5e0sm10910899qkn.31.2022.06.09.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:16:12 -0700 (PDT)
Date:   Thu, 9 Jun 2022 14:16:11 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: fix and cleanup device mapper bioset initialization
Message-ID: <YqI460bUfFdsn3I5@redhat.com>
References: <20220608063409.1280968-1-hch@lst.de>
 <YqDneqyp33PvkCLm@redhat.com>
 <20220609041149.GA31649@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609041149.GA31649@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 09 2022 at 12:11P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Jun 08, 2022 at 02:16:26PM -0400, Mike Snitzer wrote:
> > All looks good to me.  Are you OK with me picking up the first 3 to
> > send to Linus for 5.19-rc2 (given the integrity bioset fix)?
> > 
> > And hold patch 4 until 5.20 merge?
> 
> Sounds good to me.
> 
> > Or would you prefer that cleanup to land now too?
> 
> I don't think Linus would like that :)  In fact even patch 3 might be
> 5.20 material.

Ha, yeah I agree.  I'll just send the first 2 (likely tomorrow after
more testing today).

Thanks.
