Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C33C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 04:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436C2081B
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 04:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ErzlYrlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCIEZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:25:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34728 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCIEZm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 23:25:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so15592743pfn.1
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 20:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6fLOqznbhu0/LXvUZXg8MRbkNFiwpKwc2YMDPH5yQwA=;
        b=ErzlYrlHDHr7ktgcS9DL9/9VT5ui2WBWZphgkso7FXboB5yURyB0oI1r8v88dJSwDs
         A7zFjpDyX+dYkdA2c9n3KyF3Vzjci2Fevs8RYB+XTuYlur880wobvmWjgCYqFYosKNQY
         27nZgPqANf0Y0bmQJIQDYQGdTCucDWOTdHRyprpy70LzASg9ru1Od6Ew9zV4kpXzv/Ji
         M5NGnPJE70bTTIFL9z+DYvhnbo3GFK+f21bkEuduAhfH9PFLFIAAD/wCtY2VFg3+OUoY
         o3rQL2uB3txYHwkBsEBIjeIayFj22M8+464/bhkIcUl80aK76IHnafQdVYU/xCmgORfl
         InAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6fLOqznbhu0/LXvUZXg8MRbkNFiwpKwc2YMDPH5yQwA=;
        b=L+oECgSe3D7HalVEzzGz7tdD1vson82uiE703tVfyVj+zXIY7oF9+j9NaVmhf1XRml
         LVGV9RI7ZAyfIKlOvquzM/cFqTJR6wIJUnoRAhfJfil0eFyOERT4HzCXsHvCiTFVJlNs
         IdAzAjk9IFIpS9OhucDkupoBUm3IGoSyuE899K/LkEx1KuzozF4hqf6wRHBSu2P1mp7Z
         E7UGWhtL9Ed8zEcGuHYDT8ljrUPgKFG77a0E5rryvWOSCYnrWsbS6RsgK1Vz1+oJqjam
         X4jHfvCqu4TJunPuHz/UdXJJ88CVLXSsw76EWrEzjWmtYAPvKDMMozXDFGXKqQ+po0Gg
         22yA==
X-Gm-Message-State: APjAAAVULm1QvEIVRez17bMytYsONh9bD9dkG7RRnPyNc5WRLJkkBwtw
        EAYJYJzwZxqN4PYYyX6IMAAjOFWdwJz8Pg==
X-Google-Smtp-Source: APXvYqzUC3m41z7QDxiXubb5RIzZ0ck2M1oQluBlPg2PZEVOhu8FrSTGpWWZp+yWl0WF9NcRe6/DSg==
X-Received: by 2002:aa7:8a0a:: with SMTP id m10mr21896424pfa.129.1552105541824;
        Fri, 08 Mar 2019 20:25:41 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h11sm10947353pgq.57.2019.03.08.20.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:25:40 -0800 (PST)
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk>
 <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
 <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
 <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
 <CAHk-=wh36F+2iXMz1dxGxVebfFYtqypGXRchqttJuJ_=A9ctZw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6cc0763f-8a48-c61a-b831-4326345aa68c@kernel.dk>
Date:   Fri, 8 Mar 2019 21:25:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh36F+2iXMz1dxGxVebfFYtqypGXRchqttJuJ_=A9ctZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/19 5:08 PM, Linus Torvalds wrote:
> Oh well. I'm obviously not entirely happy about it, but the refcount
> issues look fixable.
> 
> So I pushed it out. Al, mind taking a look? Jens claimed in his pull
> request that you've already looked at the refcounting, so I think the
> only issue is whether it shares the bug with fs/aio.c that I think it
> does, or whether it might be avoiding it because of doing things
> slightly differently.

Sorry for the late replies, was away.

The refcount req business all rests on the poll command implementation,
which is basically a straight port of the aio version. So I guess not
surprising if it suffers from the same reference issue. I'll take a look
at the patches that went into aio and apply the same fix(es) to
io_uring.

I'll let Al expand on the AF_UNIX socket issue.

Thanks for getting this merged! I'll be on top of squashing the above
two cases asap.

-- 
Jens Axboe

