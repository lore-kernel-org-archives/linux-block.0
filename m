Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF35C7EE2F
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 02:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjEZC3p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjEZC3o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 22:29:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB813D
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 19:29:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f5685f902so26942666b.2
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 19:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685068181; x=1687660181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFUluCk6Yg3CJh7zCYAWn34AyV3ksw1s+RmFmqdT4VM=;
        b=Nb3wIdJXogNUmN3PMNhG8ePr98aCwxYjJMnIkdWW8r+lovISuI100UDFy5YFHdqy2A
         YnFDCafoMLMrBo/TAJfAdiLAhocc4xSmkmhSTou8NdYav/6OBU/E6TnmJKjSlaKiQg9n
         oIhzXKGARAMNYA9UWQQzDz8qS5/aBVoGajDIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685068181; x=1687660181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFUluCk6Yg3CJh7zCYAWn34AyV3ksw1s+RmFmqdT4VM=;
        b=Qj17qb90y6r6NWNq9hMsT2hrMnzy28VPGuyn6sxeJwR6M4ik0Q/ZTyzz8fD5ey8a+N
         TO5IdhGkLqEWfgw3j4QJ/u8N6ET/u2q8r8LF07v3dRXrkoC9Q28u6XfDBtwgBGYdxt+A
         Btrwbly+zNDcrUlDUVEmoTfTfKXyouZS6Gwkhxc8ZYvqltKbZoD9sDPSC0xfNGK9MxV3
         u8YV3SrVWvr4foTkN6RFulJCBOA/3J8VQKpbi9ODLhHJ37GTjw50btKZ1iPi3labKcAd
         1VvXdjJMge1jl+89k3AweaCQsLThdmpRugmnptIiB0O3bEdcuaTIJ/7if6p0RQfG1lva
         yETA==
X-Gm-Message-State: AC+VfDye9bXIUBp0Ik9HJMZ5p9fcN5fWHu4YQO6RwsmdQJz5cJHFQVmn
        KrUO0OqANrTIkThIWdx8csyzJC8E2aHekiGCygMq4WBi
X-Google-Smtp-Source: ACHHUZ6vcbJVb1s7TEnm5Xz9PnJkgWVFmoE9XBxLqi+h+mLHvmcMPlgbAHa3WdIGLtmapM/Rr5R+VQ==
X-Received: by 2002:a17:907:7b88:b0:969:9fd0:7ce7 with SMTP id ne8-20020a1709077b8800b009699fd07ce7mr783746ejc.11.1685068181018;
        Thu, 25 May 2023 19:29:41 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id u24-20020a1709064ad800b0096f67b55b0csm1564781ejt.115.2023.05.25.19.29.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 19:29:40 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-96f6a9131fdso27598866b.1
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 19:29:39 -0700 (PDT)
X-Received: by 2002:a17:907:d10:b0:96f:d345:d100 with SMTP id
 gn16-20020a1709070d1000b0096fd345d100mr533983ejc.59.1685068179297; Thu, 25
 May 2023 19:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230525223953.225496-1-dhowells@redhat.com> <20230525223953.225496-3-dhowells@redhat.com>
In-Reply-To: <20230525223953.225496-3-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 19:29:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=win3ttfr2xb1JcGroPSOoqGs0GooZq0DLsRtZzXUH5YeQ@mail.gmail.com>
Message-ID: <CAHk-=win3ttfr2xb1JcGroPSOoqGs0GooZq0DLsRtZzXUH5YeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] mm: Provide a function to get an additional
 pin on a page
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 3:40=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> +void page_get_additional_pin(struct page *page)
> +{
> +       struct folio *folio =3D page_folio(page);
> +
> +       if (page =3D=3D ZERO_PAGE(0))
> +               return;

You added that nice "is_zero_folio()", and then you did the above anyway..

               Linus
