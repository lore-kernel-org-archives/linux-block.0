Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05BEC07E95
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 00:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD15F6113E
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 00:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbhGSXb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 19:31:28 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:55101 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354527AbhGSWUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 18:20:43 -0400
Received: by mail-pj1-f41.google.com with SMTP id g24so12594359pji.4;
        Mon, 19 Jul 2021 16:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6pg2i/azcWb8fV5GRB9TXpG0kxE6pMvcP1mwssbbB1E=;
        b=dY5sj4KZ1RwP34q0oi+lldDoAFu1NGM1ESIwo5khbK73EBQ6Z+OaWY+WWrge8So9jT
         EWt997TeopT/oNYmW8QxUCZBfUINngG8LQylnk6tAEGTQKRf8QbJT7jxLkqWuW46c+Pa
         tVR6yFAZXqoMQfj3maaeGvmTn6dGlAw9rXNwRujnw3WrUxOW7uBZNPLNgmcbuwJp9slO
         CkJhzi/NyPKSrNdmDDUhaKSH2EAF72bNG2XCRTuAEuZj8bqZYE23AFCT/IPSyQ25FCAq
         JFnAitp71n7QLEPrXasQ1osnQQlj6ylxP56d3H91GJFVIU4wDHAI8TMNsC/Nv7pvs4hq
         EDsw==
X-Gm-Message-State: AOAM530SPf8Q/qvGc9d3EZ2B/QsOprIy0wggOOyXXBXMPlWPD/5sDiqm
        aoVMotxrwEe57xAjOzVnDAc=
X-Google-Smtp-Source: ABdhPJyf3kntOiyFjtzdBFjhJlFSOhbtmvf1HxErtiJNE0ulq5JA34OQQeWh8FISvl2v5kb4pOH4uQ==
X-Received: by 2002:a17:902:d4d2:b029:12b:72cf:9178 with SMTP id o18-20020a170902d4d2b029012b72cf9178mr12783201plg.53.1626735659423;
        Mon, 19 Jul 2021 16:00:59 -0700 (PDT)
Received: from garbanzo ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id o184sm23823355pga.18.2021.07.19.16.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 16:00:58 -0700 (PDT)
Date:   Mon, 19 Jul 2021 16:00:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] block: skip queue if NULL on blk_cleanup_queue()
Message-ID: <20210719230056.wekatjwyuzt6zzok@garbanzo>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <20210715045531.420201-7-mcgrof@kernel.org>
 <YO/fvbe5LeAP2Mtq@infradead.org>
 <20210715190726.xlukndxddvph4fx6@garbanzo>
 <YPVK1SPI0ZWmkOgd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPVK1SPI0ZWmkOgd@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 10:50:13AM +0100, Christoph Hellwig wrote:
> On Thu, Jul 15, 2021 at 12:07:26PM -0700, Luis Chamberlain wrote:
> > > For all drivers using blk_alloc_disk/blk_mq_alloc_disk there should
> > > always be a queue.  The others ones aren't ready to handle errors
> > > from add_disk yet in any way I think (and I plan to fix this up
> > > ASAP).
> > 
> > Have an example in mind?
> 
> The only ones left are nvme, dasd and scsi.  NVMe is trivial (attached),
> dasd needs a little more work, I need to send up a WIP to the
> maintainers.  scsi is the real problem and will require a fair amount
> of work.

Alright, I'll wait until these changes are merged before sending those
driver's conversions. Without this patch though, there's no way to test
the error injection in case the driver was buggy and removed the queue
by mistake. Recall my first patch moved that check to the beginning too.

So we either skip that error injection test ... or not sure what else to do.

 Luis
