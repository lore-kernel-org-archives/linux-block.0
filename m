Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE8AC10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8F72084E
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz7CGqzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDMJYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:24:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38616 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfDMJYA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 05:24:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so13760644wmc.3;
        Sat, 13 Apr 2019 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uA9/xlxsSJ148+2ceiEFkZVsJ7Hdw5UodlftNZwI7BI=;
        b=Wz7CGqzK2542nOZFGiCs7c8aKRlHG7sU4MP1YgYbHaS/uH7OX++qg2V2fhH+CeFwKx
         Bb+i2lSpkLLdFzvwJH+dqtpa8QakuALZLO9enby0cJWvEcweJiwHyWCvmeqlj3R/wrid
         J/s2Prztyt/PY5I/OgGe6l4IGu74l3ibhXFJ+UalYf10Jb9szfdl3NQ2/vUlJR/INi3n
         MuhCdzhMWQluEpHXXoA1Mfz+qPBXPcjzJcFeqSdV/4J6yE3QSzB/lGYBJMeYzi26Z7Wb
         eeSFXOjL0psNOLTkwW966VIE+OnK/H5NfRgMQ/VDAiDs+9SrkWlA0c+EqphR3lmKrrMh
         AUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uA9/xlxsSJ148+2ceiEFkZVsJ7Hdw5UodlftNZwI7BI=;
        b=qy/I6zZazVUjW18Add1a7uVS1n6bgdB1lukKmTiPYblAvL+N8NFUHAjgatX3zJAjq9
         o+i1k9QEWSJiGtBslmzzD7Pe8aVLWlX3TZX1BnsiOcvfYYQjvHegddkv+dW+Ycpb7opr
         ueJFzUSeiw1Chpm1sS7s7X4vU2N5kRjhCq3tskumdnCb2QnS27DN1NQ8l+tpIafhL3Nn
         p9VzoyfewYma65rdpyKJRRTkccoJacW9hGWO0x55adZfUPvRHCn/pow6GF5WSjMHsEwQ
         brBEC0Wf0A1A7fWXsd4tBGGtN+Ay/E0VOlHq4lUxP4ZiP+fdql3dGlmSdBJ0lU3ukU3h
         MFqg==
X-Gm-Message-State: APjAAAXk7dvWzzZ+Y8bXNE8uNAEuLTkHihByJoc0uTqL41pv5QN+y1QR
        J/k3rxfdgXLxODcF4+qvdzSNgBRtCVtZ6NWlbWY=
X-Google-Smtp-Source: APXvYqwcpgMiHzB928lS2IGsAqmluTu3w9N9RhH90+CpPS415spsrqIW+p+mibiLzHskHFYz8l0m+brzqBjQZAOWG6c=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr14669537wmi.69.1555147438276;
 Sat, 13 Apr 2019 02:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190412033032.10418-1-ming.lei@redhat.com> <20190412033032.10418-10-ming.lei@redhat.com>
 <yq1o95akbxj.fsf@oracle.com> <20190413065608.GA9108@ming.t460p>
In-Reply-To: <20190413065608.GA9108@ming.t460p>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 13 Apr 2019 17:23:46 +0800
Message-ID: <CACVXFVN4K3f=4mFLYjxpzWsFKyR8fDj=9gJb_OoskzFQX+bbUg@mail.gmail.com>
Subject: Re: [PATCH V5 9/9] SCSI: don't hold device refcount in IO path
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 13, 2019 at 2:57 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Apr 12, 2019 at 08:04:40PM -0400, Martin K. Petersen wrote:
> >
> > Ming,
> >
> > > scsi_device's refcount is always grabbed in IO path.
> > >
> > > Turns out it isn't necessary, because blk_queue_cleanup() will
> > > drain any in-flight IOs, then cancel timeout/requeue work, and
> > > SCSI's requeue_work is canceled too in __scsi_remove_device().
> > >
> > > Also scsi_device won't go away until blk_cleanup_queue() is done.
> > >
> > > So don't hold the refcount in IO path, especially the refcount isn't
> > > required in IO path since blk_queue_enter() / blk_queue_exit()
> > > is introduced in the legacy block layer.
> >
> > This all looks good to me. I assume it will go through Jens' tree?
> >
> > Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
>
> Hi Nartin,

Martin, sorry for the typo, :-(


Thanks,
Ming Lei
