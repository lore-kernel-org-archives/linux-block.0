Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9466C33C9E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 18:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DD021744
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 18:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="didMPmIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgAGSZb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:25:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38711 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGSZa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 13:25:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so266230qki.5
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dOR+K1ncnhPYV3jShNhhaRqIVvIIfeqkcrZztx4tCT0=;
        b=didMPmIA0tc6k6INSrF+hb9ceSMwHRwM6PbQr0gaEkiMXKAQ0M1mAJ9+bhuf9RVaC2
         qCuej3M29reZ9rBAjI4y92wUX8SgBjpg4lCry1KCkLZMXkfZToju8nO7LKo6IU91Nsi8
         ip5efLngVMBZGe0AyEPYNvFTtysOgK8DFuzTQLeNoMBodTuhZFXTGpky8jsMaM0HsFwS
         zwjcuvhL4HtfmdqB7AM+TT4ZWZxQnFGUH5X40gAYS02whXYsGzFIPuII3sWN2XmRwmBc
         mfy37siyI0wWoqYox8o8EVCvDyc7pOZp1YLclf9wDo9CMi7V6HGdscD58a6DgJ/TQ2PH
         0AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dOR+K1ncnhPYV3jShNhhaRqIVvIIfeqkcrZztx4tCT0=;
        b=lhZ/OphEfOPVU9SvtBJOb3tYc71+aa3KsngQ12g/tGHJ3X87jbjoTaJJt5n7h/xBW7
         IeApNkAamO2PJV/t8mHM5Ybmj5+fk40i3Ud59xaBN/Dek9m5wp7VnHv8rCQATtl3C7k7
         +SGmFkhxeGxmZjxHCStIceoYx/wFe63LsviKlX1HQRuKAhmxgWZrPXHoAyzcWOVyIyqJ
         YAbrGPL3PufwgUSYkbe9C0fFR8cPAAuc8Q7vbp6ZBUb0nUAYDwG43l1X340CqMpg0J88
         0xg4mOt7FvmhV7xKFbKetT6eE/3cdRzxXllNfUxZSweFpqbFc0SeiKWKd1WFri2oqqK9
         bKnw==
X-Gm-Message-State: APjAAAWNb8th0qgxi5wX9B+mvgv3NNqo9q6dMb1y25ATP5+7BAf+X/z/
        j17OQfrygvzRf2Tft0C4dkocdaeceWo=
X-Google-Smtp-Source: APXvYqxZ5kMw7iRRyhUHoE6hJP5D8mKrqkB4NK/JakvpKB061ba9HTmJ6H4UOqYdrpZHmed4WxfEDA==
X-Received: by 2002:ae9:c205:: with SMTP id j5mr661226qkg.58.1578421529949;
        Tue, 07 Jan 2020 10:25:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s20sm174023qkg.131.2020.01.07.10.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 10:25:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iotXk-0008PJ-PX; Tue, 07 Jan 2020 14:25:28 -0400
Date:   Tue, 7 Jan 2020 14:25:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Subject: Re: [PATCH v6 10/25] rtrs: server: main functionality
Message-ID: <20200107182528.GB26174@ziepe.ca>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-11-jinpuwang@gmail.com>
 <3fa42a11-5a85-f585-fed8-e8a2c0d7a249@acm.org>
 <CAMGffEkhf8O01F-78LJnqiASsGsfdR9WWENPrPtrTOUYUp6=gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkhf8O01F-78LJnqiASsGsfdR9WWENPrPtrTOUYUp6=gw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 02:19:53PM +0100, Jinpu Wang wrote:

> > How can posting a signaled send prevent that the send queue overflows?
> > Isn't that something that can only be guaranteed by tracking the number
> > of WQE's in the send queue?
> Selective signaling works. All we need to do is signal one WR for
> every SQ-depth worth of WRs posted. For example, If the SQ depth is
> 16, we must signal at least one out of every 16. This ensures proper
> flow control for HW resources.
> Courtesy: section 8.2.1 of the iWARP Verbs draft
> http://tools.ietf.org/html/draft-hilland-rddp-verbs-00#section-8.2.1

Not quite. If the SQ depth is 16 and you post 16 things and then
signal the last one, you *cannot* post new work until you see the
completion.

More SQ space *ONLY* becomes available upon receipt of a
completion. This is why you can't have an unsignaled SQ

Jason
