Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A70C7EE22
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 06:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEKGw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKGwx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 02:52:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEAB4EF7;
        Wed, 10 May 2023 23:52:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so76177351a12.0;
        Wed, 10 May 2023 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683787971; x=1686379971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uRe1w5FWeqoWKmR0bHUIMrdBbrMcG1q+nVCKm02YZco=;
        b=Hv1WB+7EyzwgPCJZDduY7FX8yxPzQkS4A8oTWwnakgoABcYcR6I6e0b84zScp95khk
         fKHtuNDTMSjY8prA5qFKatasF2JLd/VSxeIBScEqCNKOFMyoZ3GIfnEu9/1CMg/0PQfC
         NjJpZKeJSZEGVdzGoCKvKS3CS4uj+W4ZWi5TwdS2OcS2JOs/4+l8FEzHjnTUO7tmp0XB
         WALjQTj7VcDq2x5KPJxNrYxGOV1gHwJGcwELo/oiMcSDTtFPpikACwCtXXCt3BmJknmu
         KhvbUpk5drWkq4uaqPLy18fjTNBnb6stCMa+w5r+StWCtSeKf56aHidtR6YES/Adxow3
         izEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683787971; x=1686379971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRe1w5FWeqoWKmR0bHUIMrdBbrMcG1q+nVCKm02YZco=;
        b=lYlUWv55ytpNPCMxvyZqU6QvZBsiFfP8371lwGWcBV5c7YXZvkyAl9+WuHThd5ztHV
         7hECtO7wVtULvzbO72D6pqE4Uj6hbUBXDijNCDv79+cvuWYLKdOba2RLRczYiWg9qZ1u
         yRb/6naJjW4awORHmdlaDkLNIuc5FU40/USYs1LHj8BEj1xYMUC/nC710aWimZ5dE/qB
         FMeKbMpqbwt//FyvnRz9paT2/1zoo5S4bym2ouNgN8T+gSd7Ju01/r3tgQAbuK8SeCdM
         Y2qyZgbyScapsw90r1rMNyRP2HKkWh3ALbGoaLrDqHul4/AR7pmDEno7zFLLr7tLfqdd
         rgqw==
X-Gm-Message-State: AC+VfDxgLyp9f10Jd1mrGV0OXxrzZHrLKoKj03KdPKdVGkFpYI9TKqM1
        lLKxSa2cvMW/hYRxDIZ5T53yXE/6khhuideXC28=
X-Google-Smtp-Source: ACHHUZ7PGE+Um8vm5gLFQjqAYmw+XEoUHkJYyiYsZK7SwIH25IV1XkshnicZkVyNT3LK0zug3M56wLn8vqD/UoIQE4M=
X-Received: by 2002:a17:907:1c8c:b0:965:cac1:53ad with SMTP id
 nb12-20020a1709071c8c00b00965cac153admr20395001ejc.8.1683787968886; Wed, 10
 May 2023 23:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230503090708.2524310-1-nmi@metaspace.dk> <20230503090708.2524310-4-nmi@metaspace.dk>
 <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me>
In-Reply-To: <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Thu, 11 May 2023 08:52:12 +0200
Message-ID: <CAA76j92c1e9E7ik_k_8gqfrAczdReKwH0ZvviFMv+7rr1_GoNA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/11] rust: block: introduce `kernel::block::mq` module
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+    /// Call to tell the block layer the capcacity of the device
+    pub fn set_capacity(&self, sectors: u64) {
+        unsafe { bindings::set_capacity(self.gendisk, sectors) };
+    }

Nit in the comment: capcacity -> capacity

Cheers,
 Sergio
