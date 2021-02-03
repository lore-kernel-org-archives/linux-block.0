Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE66C433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9666664FA0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 13:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhBCNzO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 08:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231750AbhBCNyl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 08:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612360395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DhEofLaMJjZ1tt7Cq7N3qGi1/742c/Y3DEA1AwMW1g=;
        b=fbDBWmKLQ7qq7Z6fZsy9efqXXmqRRjZhLModlUWaDgyx6FZg+HrC3TDRu8Nk/Cx8Nf5Ma7
        Z6VZCakmpd+wK5LKRJnN+nV0yCknxoefyqueN4C2OoNDa5y2/goD4MpTTj5pPOBdBaDqPU
        JaNJ1VxBOf7VGrwz4Wf5M5fETLOtaaE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164--18rjaeOMFaQXWjyTxEo0A-1; Wed, 03 Feb 2021 08:50:26 -0500
X-MC-Unique: -18rjaeOMFaQXWjyTxEo0A-1
Received: by mail-qv1-f69.google.com with SMTP id h13so17832725qvo.18
        for <linux-block@vger.kernel.org>; Wed, 03 Feb 2021 05:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DhEofLaMJjZ1tt7Cq7N3qGi1/742c/Y3DEA1AwMW1g=;
        b=cwoDSHx4FP+p8Ne9ThGyLYR3+AaTPWR+9qz5+ZR+LJlAVeYT56sBrXOpOS5dDTcWd1
         8SFmPlC4tJYxPEKKKVuGILfbRy1FuUnPJIxH0dcRTsQhROoswcdlxeUHki1kDi0H4kYS
         I36KU++8reCnjNnnxSvFA4c6DhC8ApRTb+B2/5lYY5djPkyrtIhgMunqHODsOFTaoD+I
         FLgcupHJYPbUc/Hk6f2lJMqe4Jn/tYEijYrjMACKfOfRAYCa7cHqik9y+I8S9NibBvKT
         zAA2gENbDMhZwV+jK++rEny7+Cffn5Ydgzx6q+ldwEubHhIwPZSV4Tu+R+E0AFd8iDrl
         XHYg==
X-Gm-Message-State: AOAM532hCFaCcA7TypWZ1xIoQMst2D2eLYl6C3mqRyJLNuzkwJ5e2dX9
        E0/4wBhFXGziZgKjUZvpBpLHQE0vRf1TavvNhVpq6fqMo1eOsqn/vrpA8E4jbkTrHzIbgS+Amnu
        iDh4EaIKjp2gKE/NWPeFnA8k=
X-Received: by 2002:ae9:ed04:: with SMTP id c4mr2457897qkg.289.1612360225726;
        Wed, 03 Feb 2021 05:50:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdpG6zb1OO0QuYugj8PvmHLYZmdPd2y0ikD+0cdb6QgqAXJKDD8pYPXUAgkWzhbsUrGx0R8A==
X-Received: by 2002:ae9:ed04:: with SMTP id c4mr2457888qkg.289.1612360225548;
        Wed, 03 Feb 2021 05:50:25 -0800 (PST)
Received: from loberhel7laptop ([2600:6c64:4e7f:cee0:ccad:a4ca:9a69:d8bc])
        by smtp.gmail.com with ESMTPSA id 75sm1349448qta.68.2021.02.03.05.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 05:50:24 -0800 (PST)
Message-ID: <de50b6b8c867ec1f88df54f92134a99b086da8ac.camel@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
From:   Laurence Oberman <loberman@redhat.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 03 Feb 2021 08:50:22 -0500
In-Reply-To: <BYAPR04MB4965222989DE60A2F198358286B49@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201164850.391332-1-djeffery@redhat.com>
         <20210202033343.GA165584@T590> <20210202204355.GA31803@redhat>
         <20210203023517.GA948998@T590>
         <BYAPR04MB4965222989DE60A2F198358286B49@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2021-02-03 at 03:15 +0000, Chaitanya Kulkarni wrote:
> On 2/2/21 18:39, Ming Lei wrote:
> > +		/* fall through */
> >  	case REQ_OP_WRITE_ZEROES:
> > -		return 0;
> 
> I don't think returning 1 for write-zeroes is right,
> did you test this patch with write-zeores enabled controller with
> the right fs that triggers this behavior ?
> 
> 
I tested the first iteration of the patch fully mounting an XFS file
system with -o discard and creating and deleting files.
That was our specific RHEL8 failure we were handling here with David's
first submission.

I can test his most recent, I have not done that yet.
Again, please follow up with exactly what you want based against
David's patch and I can test that.

Regards
Laurence 

