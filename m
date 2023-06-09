Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE3EC7EE2E
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 16:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbjFIQHm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbjFIQHl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 12:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9B26B9
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686326824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5J35VrNmjkpODYInc7dhrWj/0vYQzkKJNessU6AYz9Y=;
        b=bP8t4KI+C7fn16u7jhaW2HkXk1AH7VXn+lyR8Np7eBmcK9pWpNDiORo/pZgX3UU7Gk0o1X
        mhENbjrsCJiiGMJqJZiNWmKUBic0AiBRujJlfuzjxqQ4awN8WTI6/sSQ5Lg+9h8WHwytZo
        8sX9y0W2hnL88pRLtKTQF88fnA9rKUE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-XO0tS2eyNmCUToR7-vx4VA-1; Fri, 09 Jun 2023 12:07:02 -0400
X-MC-Unique: XO0tS2eyNmCUToR7-vx4VA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1034578f8f.1
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 09:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326822; x=1688918822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J35VrNmjkpODYInc7dhrWj/0vYQzkKJNessU6AYz9Y=;
        b=WI5mfZ+xJZhL0FkMueSjGVIpKCW6RJ5r+VOTF2Z8XHvILYFUBzBcgRmLmPXhE/xOc3
         16qJnuYTSTvAFqIM3xIjjnX1QXe5axmWGSb0U+PDth6PjubWoG7X63vfKzDREH15p5vi
         0UdeEZgUf4wK/7AiN73Abtsg1y6Q9AdMffIiUNSXGhxyo4/ng0i5HRN3CVtrxK+QxLZA
         JVocK0DHUpB3/svVunmafAL6lcb7bTOvKW9C4uwVh9C+nwIiP9WApOxsQ3Xk+fBHano9
         nlW5E1MvfnW4/AmbkHhW4ttmbNoJVOy0FMwTY7THnJNxQD32tOg9QNVxGzX8csZqxSis
         0dYQ==
X-Gm-Message-State: AC+VfDyAUvosMVb1ObrK2jT2rKn/o+blZscvSwLD2lPFppH7bJF3bKNj
        eMe4V7ao7QdO2QkyDsDvTd8ik8LXFg3rXb5mH1MlZcFyiLxHci6Qc4632eQkTFtOiD6tBwCntaK
        4R/r9bjxEp6qt+ogzoVnuNN4=
X-Received: by 2002:adf:f3cd:0:b0:30e:3e9e:207b with SMTP id g13-20020adff3cd000000b0030e3e9e207bmr1298064wrp.32.1686326821881;
        Fri, 09 Jun 2023 09:07:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DeQtK3V76CSYnkOLZjiyDe1V9OpmIcOUfGabiu2EYTXXG/qEevQqBoZxHqU1eCbAno6PjKA==
X-Received: by 2002:adf:f3cd:0:b0:30e:3e9e:207b with SMTP id g13-20020adff3cd000000b0030e3e9e207bmr1298046wrp.32.1686326821563;
        Fri, 09 Jun 2023 09:07:01 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6e8f000000b0030e6096afb6sm4894148wrz.12.2023.06.09.09.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:07:00 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:06:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Roberts, Martin" <martin.roberts@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Message-ID: <20230609120622-mutt-send-email-mst@kernel.org>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
 <BN9PR11MB53547AEE6DAB355D5C04BFE98351A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <20230609054122-mutt-send-email-mst@kernel.org>
 <BN9PR11MB5354B884C2C89BB6AF1092B48351A@BN9PR11MB5354.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5354B884C2C89BB6AF1092B48351A@BN9PR11MB5354.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 09, 2023 at 09:49:18AM +0000, Roberts, Martin wrote:
> OK, I didn't realise you had updated the patch; I only looked at the first one.  I think you did the same as me, just changed vbr->status to virtblk_vbr_status(vbr), in virtblk_poll().

Yes exactly, though testing exactly what's on list is always a good
idea, just to avoid confusion.

