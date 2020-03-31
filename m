Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F538C2D0E8
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 07:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4E20781
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 07:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="NhH9Aqnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCaHXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:23:35 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39625 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCaHXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 03:23:35 -0400
Received: by mail-il1-f196.google.com with SMTP id r5so18443575ilq.6
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYmhvetgwgJB3/SNAs9Ay4+GNdd0buNQ8ScCdL5qIAo=;
        b=NhH9Aqnwn/jz9n5nmhhg5FmBCES9+80n1eqtkI4oil9+I157ZCyWonmXousXTYXiec
         omrLkGkVIJDzsGte9wa+X1iCcmPQb+ekIWwnl3o8pR9jqYfH/7W0DGAmfG/1fLnEt+WT
         GBxOr3oPH2faNZh7vAeR4aZf5Tun1GU9IRErfuzw3NhyjxT7rPMxao3YQE+9ILjz3mRN
         UBu/L2VkTdzZC5AGHbcQlp6E+ahLF1lkNTokNwxrIs2/6sKsHdxnAel/kSgs80jOODMW
         pYrxOKsv56J8TQtn/Gxq7Cg0J4dC+UtSLAUsM1WtHf7JnQFcM2rEfhNsGrWpJ9aa1c3c
         0NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYmhvetgwgJB3/SNAs9Ay4+GNdd0buNQ8ScCdL5qIAo=;
        b=suHj5mXBXS9vaT4Dc/ZGN7a9K3knAuGO2IOIngKwAVuh/6htp4URm8eJTpt0ObiuDn
         +r+AiIwcNMHMm32NY73EsWUET4LDz6jUswh+72gVbwku119LOeQ+l4P1cOfd+7XsLn4F
         H12iipejl7x4WCzxJlrLlWgLIZ0Py9CEMLGTpinHXxUK7SAX2gnlnYuUxCrdYqItAt0V
         XMqHhELIuve5ede2TtuuW0auyzHU5XV1MLAQT2Tv+o8RatyHTTeMwmF0yq8rVKQs4piA
         gtUI1MVY5JXU07WkykR5XGMzzqjBJVrQxSzxXvxrcmYbywBHf1R7BAD1Bpyvy+4saZC4
         2yAQ==
X-Gm-Message-State: ANhLgQ3gBVmoC+5JDjmO1qSrMXLaXKoYLz7oj6UnJJfaPJCDDsUMtm3U
        EdzWvjinLH9u/SwjFxta0MR2mExADT8ohZ29iqFMfg==
X-Google-Smtp-Source: ADFU+vviX+IfrrdYTDhxf766mcWvYHTwA5u5Bqq+BCi0GBesPQ5JpHC7+tlOjcPdC2VP5OHwNQf7J5yyBB0Xp2sXbU0=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr14705790ili.217.1585639412583;
 Tue, 31 Mar 2020 00:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-25-jinpu.wang@cloud.ionos.com> <181aba74-b942-2faf-060b-89782c8f804e@acm.org>
In-Reply-To: <181aba74-b942-2faf-060b-89782c8f804e@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 09:23:21 +0200
Message-ID: <CAMGffEnRZE-GBd8CwOsfY1YRq=fYzaX-2f+zHpy3CapZCAgfKw@mail.gmail.com>
Subject: Re: [PATCH v11 24/26] block/rnbd: include client and server modules
 into kernel compilation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 8:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > Add rnbd Makefile, Kconfig and also corresponding lines into upper
> > block layer files.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
