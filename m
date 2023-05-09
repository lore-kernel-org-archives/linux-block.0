Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CF0C77B7C
	for <linux-block@archiver.kernel.org>; Tue,  9 May 2023 16:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjEIQxU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 May 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjEIQxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 May 2023 12:53:07 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA230FB
        for <linux-block@vger.kernel.org>; Tue,  9 May 2023 09:52:18 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7576516c81fso353332585a.1
        for <linux-block@vger.kernel.org>; Tue, 09 May 2023 09:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651137; x=1686243137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NlCnOkM/MgxA+OhUODaj0DcPdY66ABvKJcAkS48+rQ=;
        b=bRGjMCqi1i6PgJrZujmNN9BJPOqON+sLd2ePh7wiwsFHO9AUXwfo17ex81Cxs3WEnF
         koZZZwNFnPWeZ+mYPjyhfxKMGLvox93LljI19blLgHMe5XmBgBLujHxV3SL/u6HX1YXm
         RW7XOscHMDy9N1CZgNZffOBc9P4x73zkKRwNYkb4eHZ/aNS8TWIeBEWrOagamzjjTViV
         xZGWk0ahqkUenSbl5rxxLvLuSoB2x0H/l1P0/L71vKVv8AkmIDFrmJ1iS9Oes/YTZjuj
         V+1RB0Ssba4AGgUWNckF3BcjwSFBBwT+V+IsO/BTC9gIBWROSwNL4EtGFE8cTvlpQt1n
         OLOw==
X-Gm-Message-State: AC+VfDxFDz3yDPgpC2arOMngYiPJ4CVNUPbAWZmDkx5dg19ujiWmPR6g
        0lUJsf6+VT1HDP5Ym9vy0YUJ
X-Google-Smtp-Source: ACHHUZ6sqdNZ2jTWBpQoQUne2HxU2x6SkHvDsQePL/EB6aWKWGfiLRP7QOvsu0TXIL8IYmrE41X/oQ==
X-Received: by 2002:ad4:5ba2:0:b0:61b:6872:1459 with SMTP id 2-20020ad45ba2000000b0061b68721459mr18704881qvq.49.1683651137572;
        Tue, 09 May 2023 09:52:17 -0700 (PDT)
Received: from localhost ([217.138.208.150])
        by smtp.gmail.com with ESMTPSA id ew8-20020a05622a514800b003e635f80e72sm633574qtb.48.2023.05.09.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:52:17 -0700 (PDT)
Date:   Tue, 9 May 2023 12:52:16 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v6 2/5] block: Introduce provisioning primitives
Message-ID: <ZFp6QDkSm296+Qm6@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-3-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-3-sarthakkukreti@chromium.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 06 2023 at  2:29P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block devices that support this capability will export
> a provision limit within their request queues.
> 
> This patch also adds the capability to call fallocate() in mode 0
> on block devices, which will send REQ_OP_PROVISION to the block
> device for the specified range,
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
