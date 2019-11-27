Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E64C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 12:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4774F20722
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 12:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfK0MBZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:01:25 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:33829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0MBZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 07:01:25 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MdNHa-1i0sEt3cbA-00ZSA5; Wed, 27 Nov 2019 13:01:23 +0100
Received: by mail-lj1-f175.google.com with SMTP id e9so24143957ljp.13;
        Wed, 27 Nov 2019 04:01:23 -0800 (PST)
X-Gm-Message-State: APjAAAXdfxNZTxo4BFqbIdYgtFU6ode9w7XHHPfXYUpJ/AEdBYqLNJbl
        uqtOGkrRlfxnHjGtqTdx9xVYhG7tT9Jf0b9twhI=
X-Google-Smtp-Source: APXvYqziDlqq5Dzs6upwfbV/V0hi2sCqZa+0e8VjhKCQZe+GYHkc5E8w6eo0lAiPAcdp9kqETGqKueHwK15/WGusde4=
X-Received: by 2002:a2e:5843:: with SMTP id x3mr618488ljd.64.1574856083341;
 Wed, 27 Nov 2019 04:01:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
 <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de> <20191127090023.GA23040@infradead.org>
In-Reply-To: <20191127090023.GA23040@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Nov 2019 13:01:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0gUWf_+ZmscuFanvPG=wN09ELL-JpByjJJM4Lo1FYmrQ@mail.gmail.com>
Message-ID: <CAK8P3a0gUWf_+ZmscuFanvPG=wN09ELL-JpByjJJM4Lo1FYmrQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:580VDw310m+E7/f+vrcK74DySwXU+ECbb8b2LLqYcvyh+NajzFe
 RywynYTPpgG7GDg92DZwDXH+7Qygya89VEVeeC60PBJe1ujehCpMeFsflU0+MbOOa4uMXVE
 Mzjo7kHgTbxIgWGY3qm5mo4BnWOfd8lUv/D8yCr/1PH36RDiucM7j62/WxPW9D/HHknY/5b
 +YOUAopbaSrLa6R7evbAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UcZAd24DVs4=:hJxrFWDIxCWki3o/hlc67j
 LEAomg2FJxMOTy02+HbjOTFbDy2zx9e7YQIkhDBSRXur9RkXjFAO0yIvGDr4IvIw2Mo1dz5SB
 016E03fciBajyv20XIy7Y+1jzW4uyTvj5ntGTzsUPBuJZNgXwP4do7ywWwtREdyOCPaVol25y
 jvlBPfAp/hjz9K5D8LEctwx3NZDOywq8pDBvJ72du5GlAC5jFGhZu9IuIcHlbqFwBU7LYls3E
 LAN+bZBDPIpt+UKDOh3WBfnUH9L4uJwY0npLtvd3Ar+D8HIT9OMRvsJVfdw49gGMnMvlfEyyB
 k8AajG/suN4D4TJns8fA+sZtf2C37pnfjLtfXHujehoInk6LUOWofZvVqv0g8GwfeFkd7+dwr
 li76EYIREMO8Z49BSDYPxTrdsT9LYYyzIo0SZbFht0Ygk8yC+VMvJA4JMYaCs4aT6aqVzmX97
 e0mtDxnAlyDVwMrxEo/9XsoZKAe7NE/omu6C5oLkUrqWr7zS28Ee1/ZaHirrZb8rAxRoa+IYy
 t6p5GH9VynkHxdq42Mq+ELVOaGVeytmNexazzvbFpo0vViOTSufJNfm5xsXhA+wCoTUq4LVzi
 qz022NktdMaVcbjOn5C3pyHjAQ27l5/hUcRF9XGiqYXFJCFmmBklDSLMGzKued/wSbvWo9mZy
 R8Yt6mHzGM380Rl3pVSoNd3A/XuxqNwQntS7EcqJul4vEHkkYrnSlm883XePUUAjuI89NLXXF
 xpT/18Nnf/ldcy3Pz3bZCkvNK2jlHdAg02JFk9flZvX9VoaHpwkiIQi/0jSTIvV7OK0vxk3Ue
 l41+VDeL7dI0nUiNQPK+gJ+gtXBd/StkXL8kpj2XlGPdn0yHr3agj/YRilzTU3AVJwVDuLhqB
 6syMOS+dqSA3T2duvarw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 27, 2019 at 10:00 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 26, 2019 at 12:17:15PM +0100, Hannes Reinecke wrote:
>  If requests are batched enough we could just drain
> and switch every time an other partition access comes in.  Especially
> so if people only use partitions for boot partitions and other rarely
> used areas.

We only support a single user partition plus up to two boot partitions that
are accessed rarely, I don't think there is any reason to optimize switching
between them.

The only change that I think we need here is to change the partition switch
from something that is done synchronously during ->queue_rq() to
something that fits better into normal scheme of sending a cmd to
the device, returning BLK_STS_RESOURCE from ->queue_rq.
Possibly this could even be turned into a standard struct request that is
added between two normal requests for different partitions at some
point, if this simplifies the logic (I suspect it won't, but it may be worth
a try).

      Arnd
