Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CBC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6452184D
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 12:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeLWMY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:24:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50882 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLWMY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 07:24:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so9239283wmd.0;
        Sun, 23 Dec 2018 04:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IRVDC9MlYo+zGnerOqLUxppaH+DMuyi+9dgYiggvnjk=;
        b=QMpchS5pZvidheC5OB8q4rbKWHTLZYTOw/neMJEGsG1YEBOlFZzbX/pmH8kjSmUfVP
         uGvWLErPHfS2KkXmhDgYGahPXgVnwf149AAnTbflx67vbwAsVd91l6KQDLTKV1pzF9Rh
         CITBjHB8E86EMMPJPxcKK8pjc1+eeA+0h66NYCgGiC5ZDtbeQtpNX6I+Q4gZgWleKrQv
         60cK0JEuDJMdGodHE/rzFZMmHgFPojjxe0f53qLI4dtuLvskqAdmtsZMll5Kz39jDfth
         JnqoOJXyxg2cbDvSdKZq8juPlQJWehruZeebQodrgROQBSWFsBpnuWeYtACiTuu6TrAp
         E/xQ==
X-Gm-Message-State: AA+aEWZD83zx0D5z3r0Bymc30hq7yWedAgdokKiutcjk1d4ELwmWJCqb
        h3PdhqFY15wCdVJdMNpgjAPGBUkW
X-Google-Smtp-Source: ALg8bN4FAT5pO8Jdo1DkP02fzPknXBrA26uA1ni2n7fLjNxtdcfDQXpxtv8qZlmMf5109vPSc6yZnA==
X-Received: by 2002:a1c:16c5:: with SMTP id 188mr9500472wmw.69.1545567472204;
        Sun, 23 Dec 2018 04:17:52 -0800 (PST)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id k135sm28258413wmd.42.2018.12.23.04.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 04:17:51 -0800 (PST)
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V3
To:     Christoph Hellwig <hch@lst.de>
References: <20181111133211.13926-1-hch@lst.de>
 <4f4b6aff-6726-c500-e3e4-f8b73d641851@electrozaur.com>
 <20181219144347.GB23410@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <fcba6f10-3cef-bc71-f198-e53e4a0e98e6@electrozaur.com>
Date:   Sun, 23 Dec 2018 14:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181219144347.GB23410@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/12/18 16:43, Christoph Hellwig wrote:
> On Mon, Nov 26, 2018 at 07:11:10PM +0200, Boaz Harrosh wrote:
>> On 11/11/18 15:32, Christoph Hellwig wrote:
>>> The only real user of the T10 OSD protocol, the pNFS object layout
>>> driver never went to the point of having shipping products, and we
>>> removed it 1.5 years ago.  Exofs is just a simple example without
>>> real life users.
>>>
>>
>> You have failed to say what is your motivation for this patchset? What
>> is it you are trying to fix/improve.
> 
> Drop basically unused support, which allows us to
> 
>  1) reduce the size of every kernel with block layer support, and
>     even more for every kernel with scsi support

Do you have numbers? its mainly code-segment so I don't think you will see
any real life measurable difference.

>  2) reduce the size of the critical struct request structure by
>     128 bits, thus reducing the memory used by every blk-mq driver
>     significantly, never mind the cache effects

128 bits? I see the "struct request *next_rq;"
is there another one?

It could share space with elv; && flush;
Do you want a patch?

>  3) stop having the maintainance overhead for this code in the
>     block layer, which has been rather painful at times
> 

I hear you man. Life is pain. But is it really such an overhead?
I mean it is already implemented. What else is there to do?
Please please show me? (Sorry for being slow)

Jai Maa
Boaz

