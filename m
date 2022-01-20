Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1159EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 08:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359423AbiATIuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 03:50:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359384AbiATIuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 03:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642668618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbdpZBG+JAPEFt3/QPKFPH7gsIvhnHQK8HUTdERmVKU=;
        b=XODHqTplEx1vhQRwz74qzYRMWo5KFBSivI2AbuKDQs+00mr6slazgWTgP3f46tn7hAFR4i
        nWrO4JDZ+lspUsUJaGjC1OgOg0zQhOE512DlqzfdurB2ANkEXpkT5SSRtemkeXZPwlecP/
        pA6dQ4tAA69i7D7HLeYGXU8eiuIX7zQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-vBbuS2HkN8qqc0vyWI0Jkw-1; Thu, 20 Jan 2022 03:50:15 -0500
X-MC-Unique: vBbuS2HkN8qqc0vyWI0Jkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A972C1083F70;
        Thu, 20 Jan 2022 08:50:13 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 816957B9E1;
        Thu, 20 Jan 2022 08:50:12 +0000 (UTC)
Date:   Thu, 20 Jan 2022 09:50:09 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        util-linux@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Racy loop device reuse logic
Message-ID: <20220120085009.xecitkc7f2digut6@ws.net.home>
References: <20220113154735.hdzi4cqsz5jt6asp@quack3.lan>
 <20220119085247.duhblxzp6joukarw@quack3.lan>
 <28a360a3-b559-24ec-6c3d-3fe6e8302393@I-love.SAKURA.ne.jp>
 <20220119213415.csieaktdqmshemiy@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119213415.csieaktdqmshemiy@quack3.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 19, 2022 at 10:34:15PM +0100, Jan Kara wrote:
> On Wed 19-01-22 20:30:52, Tetsuo Handa wrote:
> > I found a way to avoid this race by splitting lo_open() into two phases
> > using task_work_add().  Christoph Hellwig is trying to take a look at
> > https://lkml.kernel.org/r/f6b947d0-1047-66b3-0243-af5017c9ab55@I-love.SAKURA.ne.jp
> > .
> 
> No, you have found a way to make the race window for mount(8) smaller. And
> I still disagree with that kernel change because it is making kernel more
> complex only to make the race window smaller. On another machine or with
> different scheduling decisions, you can still hit this race. This problem
> must be fixed in mount...

+1

I think Jan is right. In this case mount(8) is not robust enough. It
reads info about the device from /sys and then it opens the device.
Unfortunately, whatever can happen before the open() call.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

