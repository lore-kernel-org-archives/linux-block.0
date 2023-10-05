Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46110E9271B
	for <linux-block@archiver.kernel.org>; Thu,  5 Oct 2023 17:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjJERPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjJEROx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2023 13:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5332724
        for <linux-block@vger.kernel.org>; Thu,  5 Oct 2023 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696525526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKcKcbN0G6E1ZA/muCY4Z4QSr4fIlnQTBllEL5N75xE=;
        b=Tqg713ATy/MOrREUtJikjb1g0g5Xa3uKoF4YwEUStwwe4NmsIcCrDhjt3WvHaSxI7fMnpQ
        igTpwqX6qUR3CL5EgLaxW9ViXGqyjSqx43+R+Xc/H83CyP8+KbVLMGLM5plsfRLxo/aZ4w
        xc+55wSh7OF9AThniz0oy7GhBFQClMs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-XZ12uclKPy6PIwXfFzFfYw-1; Thu, 05 Oct 2023 13:05:16 -0400
X-MC-Unique: XZ12uclKPy6PIwXfFzFfYw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12A563C0F670;
        Thu,  5 Oct 2023 17:05:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 36232492B05;
        Thu,  5 Oct 2023 17:05:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  5 Oct 2023 19:04:17 +0200 (CEST)
Date:   Thu, 5 Oct 2023 19:04:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Li Nan <linan666@huaweicloud.com>
Cc:     Khazhy Kumykov <khazhy@chromium.org>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
Message-ID: <20231005170413.GB32420@redhat.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sorry, didn't notice this part before.

I am not a asm expert (to say at least;) but

On 10/05, Li Nan wrote:
>
> When (a * mul) overflows, a divide 0 error occurs in
> mul_u64_u64_div_u64().

Just in case... No, iirc it is divq which triggers #DE when the
result of division doesn't fit u64.

(a * mul) can't overflow, the result is 128-bit rax:rdx number.

Oleg.

