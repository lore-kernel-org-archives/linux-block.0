Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87902E94135
	for <linux-block@archiver.kernel.org>; Sat,  7 Oct 2023 04:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbjJGEdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Oct 2023 00:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjJGEdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Oct 2023 00:33:12 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF047C5
        for <linux-block@vger.kernel.org>; Fri,  6 Oct 2023 21:33:11 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59f4f80d084so32547037b3.1
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2023 21:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696653191; x=1697257991; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXf8U8C79vuohVnXvifYnSGTERWziOzTJ9tH/XzO64c=;
        b=G2QmNI90irCvCjWIWnb1O8LJCTN2BOv7ERI/hBa0JI6wuHJTlShGtxUeitJ3doYBHL
         S0vbiyldUBj0D2oT30PloiF47sz3aWzd6RsODBaEo0D5/xXwzw7Fx5P3XLs4A7so1sYn
         qO6hlZdVEj6s8m5DRe/HElUXohTv4ltysDA+WD8oSZDNE5FabyPInoGNug9NecLS0kzn
         J91Gbjp4ylwuOe3L/1BRLFj+TG0j60JyFELC5WfAQuKw/3sdllANgDaKI9D3c1hyZmir
         I6HKWZE/+6fjdHhlcTo2O2HbQI24aZvPE78sd+58Wq5tmkBPhN5d7QzOhLHsfa7Uyi+w
         IpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696653191; x=1697257991;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXf8U8C79vuohVnXvifYnSGTERWziOzTJ9tH/XzO64c=;
        b=t861FM3rBA6P1aUtJ/djLUFd3r/U1jVmv+UBLe4sryIL/Eq6xXm0E0gwxmJwBP5ggB
         mY6W5xbRc4r/dFwe9SOyVbPeWpxQG48oFs1EV7VxMKdO6XieF0ADzTOxR2zU/NlgbU/y
         wXmLDf7zvFSmVkJOum8kq7d2nwE3Vmk71+HWR1u9vCBrv606UVS71tBbSaRpq80hC6g8
         QHKwQ1HVxh82THUmBPoKCG7awyNZJn/Wzv6cKX6UkL1F5vdyziH1q6p22jesdc53iEqP
         ftBH1vw5DhhrIzn101ZD0xEqyk9JWzegwE+bAThCpgMrXTx86IBMujaW8UoDEiMY4wJ2
         bDaQ==
X-Gm-Message-State: AOJu0Yz+Y6CRFzOewBaml6/FXKghHxsuGvfsPDdbohno+BQBdMwYek4R
        serUEQK8dhlL72Y298mv2JlkSA==
X-Google-Smtp-Source: AGHT+IGTpv8UvjCyOJzS3L3dtxDOz63ebkoFEikvvBO0NxbbM/Dn1NW+bTCtHist3Wz9lX81T/YdLw==
X-Received: by 2002:a0d:d641:0:b0:59f:4ee0:26e8 with SMTP id y62-20020a0dd641000000b0059f4ee026e8mr10164738ywd.21.1696653190770;
        Fri, 06 Oct 2023 21:33:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n16-20020a819c50000000b0057a8de72338sm1770078ywa.68.2023.10.06.21.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 21:33:09 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:32:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Howells <dhowells@redhat.com>
cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next] iov_iter: fix copy_page_from_iter_atomic()
In-Reply-To: <1809398.1696238751@warthog.procyon.org.uk>
Message-ID: <356ef449-44bf-539f-76c0-7fe9c6e713bb@google.com>
References: <20230925120309.1731676-9-dhowells@redhat.com> <20230925120309.1731676-1-dhowells@redhat.com> <1809398.1696238751@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[PATCH next] iov_iter: fix copy_page_from_iter_atomic()

Trying to test tmpfs on latest linux-next, copying and building kernel
trees, huge pages, and swapping while swapping off involved: lots of
cp: error writing '/tmp/2624/Documentation/fb/vesafb.txt': Bad address
cp: error writing '/tmp/2624/arch/mips/math-emu/dp_fsp.c': Bad address
etc.

Bisection leads to next-20231006's 376fdc4552f1 ("iov_iter:
Don't deal with iter->copy_mc in memcpy_from_iter_mc()") from vfs.git.
The tweak below makes it healthy again: please feel free to fold in.

Signed-off-by: Hugh Dickins <hughd@google.com>

--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -497,7 +497,7 @@ size_t copy_page_from_iter_atomic(struct
 		}
 
 		p = kmap_atomic(page) + offset;
-		__copy_from_iter(p, n, i);
+		n = __copy_from_iter(p, n, i);
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;
