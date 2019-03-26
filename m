Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA01C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 02:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C3420828
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 02:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyWnwjjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfCZClO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:41:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44483 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCZClO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 22:41:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so8368382wrn.11;
        Mon, 25 Mar 2019 19:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nl4uLBWGWBQQZjK3Yu6yXtDWXpPkFHrwhXjK2wY0KMI=;
        b=ZyWnwjjfhvlF9nfujwlIMS+9kPItIf6R2sYDUrOJbO7bHWg18+c+Ta123y0ZhnNJ+h
         eROUUpXhTZKhJ0RjrPigzslV2d7H3zWV4eGLxMeS/o6M++ucrqYpdGK8wtPk7EEU9UnC
         BZ+o4Pg/IZSR/kzwtltnP0ULRmR8lAKbk65DKIi2bY9zGNa+1lDjcpdkvpDWDIV2+Ltq
         K/rDyYDmjlvpnBftBqfEBMYNIaAae995bFNnTJXVetLcW7aJxiutYffjaYCNVQDHsUmV
         64KRGbJJnT0dCKg7K+EILPIUmsRFGgkhEJjTk4QO0lJ1Gadhx7gIBfHxJ1Cc/Gdadm8z
         iAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nl4uLBWGWBQQZjK3Yu6yXtDWXpPkFHrwhXjK2wY0KMI=;
        b=UGKEJDHR/h/5AJQJYvZ2xq4eC3YK+efwt3EnpQkWKtKwK4aRkkSMgfFnYMZb3/UbFU
         N8YZIwbcQ+6XqXU9wjtbTeezG5kVD/Bksg0YvZEXbbm7WgKI/X0Q8RX3nCgoTaxFFnUh
         h/Tv6ZAlJH8mf+/vGIii8PxXUr9UlGjweH7nAhBMvgSM8xmzwva3+VetaQTor3LKCIOM
         Y/eeAntKkCRhpsfFDfdnPz7UQjnudK77u3vk5usV+dmVflTRXFIqxnN9Wyby9HLu5rp9
         DFJlpK+nqTjIyPe9j6Ehs10Ly6my3QRMwPWXDTM7V8YH0GSXJ6k6tOfTb6ZHyYR3WruB
         NYRg==
X-Gm-Message-State: APjAAAV5WPvNPTD8t6MtpB7rQpLheZMFvRAdBoPM4XutWd4QlCEumf4C
        G05J56xOxjDxW9N4JkIQIuEqQj5sNeLJ93LM3Ek=
X-Google-Smtp-Source: APXvYqxcYRcGg35q02v5yt7veabmWX2V5pIgYJAHf4YH8Q7oFTLegH+w3jmgdrjGBHLxSbl17kdLrwJzUBjI+Rr3kUc=
X-Received: by 2002:adf:d848:: with SMTP id k8mr19531326wrl.185.1553568072236;
 Mon, 25 Mar 2019 19:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain> <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
In-Reply-To: <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 26 Mar 2019 10:41:00 +0800
Message-ID: <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 26, 2019 at 9:18 AM jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
> Hi Keith
>
> On 3/25/19 9:49 PM, Keith Busch wrote:
> > On Mon, Mar 25, 2019 at 01:38:37PM +0800, Jianchao Wang wrote:
> >> blk_mq_tagset_inflight_iter is not safe that it could get stale request
> >> in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
> >> interface nvme_iterate_inflight_rqs is introduced to iterate
> >> all of the ns under a ctrl.
> >
> > Nak, NVMe only iterates tags when new requests can't enter, allocated
> > requests can't dispatch, and dispatched commands can't complete. So
> > it is perfectly safe to iterate if the driver takes reasonable steps
> > beforehand.
>
> nvme_dev_disable just quiesce and freeze the request_queue, but not drain the enters.
> So there still could be someone escapes the queue freeze checking and tries to allocate
> request.

The rq->state is just IDLE for these allocated request, so there
shouldn't be issue
in NVMe's case.

Thanks,
Ming
