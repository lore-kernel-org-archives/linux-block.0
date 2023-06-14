Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D927EEB64D9
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 12:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbjFNM7y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjFNM7x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 08:59:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1613E
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 05:59:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-657c4bcad0bso1726923b3a.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686747592; x=1689339592;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWiTDY4WoR2vMCPiMoJs99ZZjQHkFPYzfNppOtM83Uk=;
        b=v59EcOngHXuVEkZBJKhEkbooddVHNoKUx29ZUcM5h6ZR8jfBhq2WdRm/mBbsi9M1gB
         FXUWTREce0bLYga5nOf4C0NZnh0JlpBGqhvm+SmdtmTPe6kAkWOxbzQwHUbM258m0sRX
         afNg877qYFRh1vD4YamWlhuSHnPUBHjmgWSFsL/3hk3HEHgE6qoObGgU/VeA3yw2rUdH
         w1cGmmZxgHqq8hoEdfcJt3SRDQ5v/YJ5KLoUXEE3sEA/ANIy603s1cwM0qZ5fjO1rNgc
         BvqAbBm129gkbGePSs///1tPYNAu+kksfg/FPj+U5fuH7O56cH7tL3/DWFjvo1UlkSt0
         Es2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747592; x=1689339592;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWiTDY4WoR2vMCPiMoJs99ZZjQHkFPYzfNppOtM83Uk=;
        b=ZlrgdFK+m8t2JRIflzucRNANQeFSZIEJWw7NlmrPRH8lARV7wYLUtcibi48gY0QX1D
         g5i+W6SszsWKHFVgviJHnjpWCcCmQqE98uh0LxES6G5fv0vo+CfxbjNsIJXvyNUSmBBc
         6W09FE4LrfoFJBFyiaDJKzxPnqgsybbWLGcLIiyZEtAK9otBU8z1CKDdVS6rKy7qH2fm
         plBQEiUk3dNBwu29lNaQKLbjA/g8bMuRYkTNou5Q1wmc6xsC87FxcxOkPVxE/3F+ptPK
         fdFPG16+sdyvGZV9jnEKPUOs1NqUgLF/L9Kf2vTtImS0zbK3W+0MZ5RLX4WEFqJI9tnK
         C/qQ==
X-Gm-Message-State: AC+VfDxF13RoeWp9Iinkj4o9o+BgQp7gpvvSjbroRyoERtB6MdP0yqqm
        ByCkZhjgIX3X9Xc6Sl7ktAlL1A==
X-Google-Smtp-Source: ACHHUZ4x2s2sq446Ucsp4FCfLgGcx3P5A6b7PePPChUdylJlNi1cN6AG2hC8cpOpsk8qWffdd/HvJw==
X-Received: by 2002:a05:6a20:54a3:b0:117:51fe:9b3a with SMTP id i35-20020a056a2054a300b0011751fe9b3amr18749690pzk.3.1686747592079;
        Wed, 14 Jun 2023 05:59:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b00640defda6d2sm10324418pfn.207.2023.06.14.05.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:59:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     David Hildenbrand <david@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <1193485.1686693279@warthog.procyon.org.uk>
References: <1193485.1686693279@warthog.procyon.org.uk>
Subject: Re: [PATCH] block: Fix dio_cleanup() to advance the head index
Message-Id: <168674759029.1685273.10047013854473081926.b4-ty@kernel.dk>
Date:   Wed, 14 Jun 2023 06:59:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 13 Jun 2023 22:54:39 +0100, David Howells wrote:
> 
> Fix dio_bio_cleanup() to advance the head index into the list of pages past
> the pages it has released, as __blockdev_direct_IO() will call it twice if
> do_direct_IO() fails.
> 
> The issue was causing:
> 
> [...]

Applied, thanks!

[1/1] block: Fix dio_cleanup() to advance the head index
      commit: d44c404207831dfe3b301ff479e964b77914488b

Best regards,
-- 
Jens Axboe



