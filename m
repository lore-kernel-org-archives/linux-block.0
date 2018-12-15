Return-Path: <SRS0=QLrH=OY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6E1C43387
	for <linux-block@archiver.kernel.org>; Sat, 15 Dec 2018 04:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774D021720
	for <linux-block@archiver.kernel.org>; Sat, 15 Dec 2018 04:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lyle-org.20150623.gappssmtp.com header.i=@lyle-org.20150623.gappssmtp.com header.b="Dn/zv1q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeLOEW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 23:22:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50756 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeLOEW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 23:22:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so7464373wmd.0
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 20:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lyle-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kL77sDMV3lUZa5pxotn9ytzS6CzqeSwXuCYiCOM5Aw=;
        b=Dn/zv1q8BLUoOc9GTKftXHDOA+hxrdZA/1f7VgpbJp6gZ9oBj2gSxKOPN9A9fYmqVQ
         ed+mxzQ4EQMjEv78vzHbUfxnIIn2L9HZ9CSzriVvcIcVdctd3UthM9kUeLmacFYt4e4H
         JpEfefTfCCPB6MTG7Q810E1LUPa7szkymmUym8RN/F9MmwsMlV2BZQcgXdUaGZPzWipe
         ltb/JP1CjG5brOmV7DmUeQ8LW7syb4Gyl5FApk8kymBWOoQ0t1kAFo6s7y1uN9E7zcsx
         E7935CkuxcxP/+ic6AK2U2vaQHMunMFtnSUY2dHqWQ4pyOSbO3XhYbvWE7OKhSorGc+J
         yZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kL77sDMV3lUZa5pxotn9ytzS6CzqeSwXuCYiCOM5Aw=;
        b=C6zeyJBf1RCUutmrRZaolmTg7RbMzJS7tQlwClFAI8mjzyBcf0Rk03gi7BLZzj6RxI
         hueLZlR7ipMSw6uSFrbp5ucahv2R4StIZTx5buckyN5QeRGYOrh+k0k57jHQUOpUgZKB
         0J8a9eALLxg5pcBsc4cjz0wjLRWj8InQEUhemBWLvhJoGO73zJri1rpC7qbZOh5bAqI0
         K8VTsxwwtQz/jTzS+6uboIcU8BU9CTH94jFsBegXwJKqmMPaPuiype3zY4SWcjT4OieQ
         Qapr0ufcdIMDzTVkg7WVh6k348As2JNWlCAAoXEm7nHgsW2XR0ecPoIr8Q7GUMWGdEkZ
         RYcw==
X-Gm-Message-State: AA+aEWbLk6osaCEAZyE2r+NUVaYf0TkGknOXp31qE4EhyJNBEPS9w0qm
        60eZ5SthUHYdfnLszFGGiinjBowIOOyT+ndndHA//g==
X-Google-Smtp-Source: AFSGD/WZsbTqIxLwVAlbocD2T18zcU2/IU4T0JHz2XgnVIM5b3Y4KBQrIvKbhEevXlMPGWFKD+RKCA/63Fsh3b/A0f8=
X-Received: by 2002:a1c:384:: with SMTP id 126mr5181706wmd.26.1544847745018;
 Fri, 14 Dec 2018 20:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20180724040310.1590-1-colyli@suse.de> <CAJ+L6qcyR2nqdTJAPwi_hKx+BtDjzX+K0guJJK7xLtBU0w64eg@mail.gmail.com>
 <8046b547-d59d-2764-90f9-27698b1011f7@suse.de>
In-Reply-To: <8046b547-d59d-2764-90f9-27698b1011f7@suse.de>
From:   Michael Lyle <mlyle@lyle.org>
Date:   Fri, 14 Dec 2018 20:22:14 -0800
Message-ID: <CAJ+L6qfVM+uSE5UbN8jtBM3F4JwYYsnZ1_R5YFkaa0Q_-J3LFQ@mail.gmail.com>
Subject: Re: [PATCH v2] bcache: set max writeback rate when I/O request is idle
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org, stable <stable@vger.kernel.org>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 14, 2018 at 8:08 PM Coly Li <colyli@suse.de> wrote:
> Commit b1092c9af9ed ("bcache: allow quick writeback when backing idle")
> just looks at single bcache device. If there are I/Os for other bcache
> device on the cache set, and a single bcache device is idle, a faster
> writeback rate for this single idle bcache device will happen, I/O to
> read dirty data on cache for writeback will have negative impact to I/O
> requests of other bcache devices.

Yes, but this will potentially fill the queue on the idle device.  If
you have an application that is intermittently doing I/O every few
seconds, the latency of the individual I/Os will be high.  I was told
during review that this was unacceptable, and revised my patch.  But
now we have merged a change that is more like my first patch that was
rejected...

Mike
