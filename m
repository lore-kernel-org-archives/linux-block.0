Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B9FC61DA4
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjCORBL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjCORBK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 13:01:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091D15D257
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 10:00:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w9so7368048edc.3
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678899645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNcufV/o6gXGVvEybdJYpsgEKHaP677A9vzHvZRO1S4=;
        b=hmklnvS8zFNaTwg4I6AQ8EgxC3rDC55Fy1yfRRBp55jWHPiflyBzeHx2PDt50zg8GT
         D8dve4rM25zjPPSNbTl+uptvWB3CXXHZbGRLv00MJOeGP99iz9VvwSrP1tZCPGdmqxt5
         UYJQJr2DMflIuMNL31dLUytSBT/8YJpsXrhPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNcufV/o6gXGVvEybdJYpsgEKHaP677A9vzHvZRO1S4=;
        b=xqdOdC3/2nM7zfFLHBFzVq+zjvxyxeWxxLnsESzNH0vHKCaGAD7+UF8CI6sQf2YbrA
         AhZftvp3oMYgEsF3DG5zIAtqoS/QkvdNGcrMdfDgwwY1T0nRSzWD8btgMmnqynxid1rz
         wGJSRrHzCNMmTrqvSwv1zyUyUcbFc5GJMHIcqZKDeEKfqeCy0AGmq3f5SqOxHjEMLWL5
         FyttPoK5D/0OfaidxvTUsW1R1bHDPZZ7J2OMieSz45wJcH7ahfUPQDO4jCobSWOVJ3tk
         MjtVKqlVSf7U/y4jsmrBTwFjib9pmh5zo9ZuZCw2NonLHNH1z5f+tF93UeYnFzlBrPvU
         hNDQ==
X-Gm-Message-State: AO0yUKUmiEErQrii1FspyCe6Amal++Lfwk4EUyshiPnJH9DPTxFJCVOz
        rOllKY4buJ2O1XRUp/tdoYkUXoCsSlDyzuP7/DPiYQ==
X-Google-Smtp-Source: AK7set/O9zq7/xJroAbpvtop5DWoqIy/Yu4l166uX/w9jy2ussAQ0pOvW1lnpLraQDCFqUHwLUEeOA==
X-Received: by 2002:a17:906:7d52:b0:92e:e9c2:7b9c with SMTP id l18-20020a1709067d5200b0092ee9c27b9cmr2565875ejp.77.1678899645246;
        Wed, 15 Mar 2023 10:00:45 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id qq11-20020a17090720cb00b008c6c47f59c1sm2786679ejb.48.2023.03.15.10.00.44
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 10:00:44 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id h8so34374311ede.8
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 10:00:44 -0700 (PDT)
X-Received: by 2002:a17:907:72c1:b0:8e5:1a7b:8ab2 with SMTP id
 du1-20020a17090772c100b008e51a7b8ab2mr4223971ejc.4.1678899643988; Wed, 15 Mar
 2023 10:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230315163549.295454-1-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Mar 2023 10:00:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSfbFAVvXpbRJ0NkNJbpo93d5ObdoHcNMvX4CYGrafAQ@mail.gmail.com>
Message-ID: <CAHk-=wiSfbFAVvXpbRJ0NkNJbpo93d5ObdoHcNMvX4CYGrafAQ@mail.gmail.com>
Subject: Re: [PATCH v19 00/15] splice, block: Use page pinning and kill ITER_PIPE
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 15, 2023 at 9:35=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> ver #19)
>  - Remove a missed get_page() on the zeropage in shmem_splice_read().

Ack. I see nothing alarming in this series.

              Linus
