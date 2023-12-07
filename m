Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8SpE+xT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FA8137
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 22:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701931124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWU3XhY3SGz8Nm4Q405d0erGPeXKkfHuFXSX394aJLk=;
	b=F8SpE+xTqNcOxnosIq2kwiHdPxTGD1nykvYX5r11gyU17crEKzI2QI07h0hPo8xtDY4duV
	L7oOYwh6Uw2oKRJWpEvRx62S/4qc78d2dKfLlGX8SSw053Erv9acqfOgCSrJ5qJmfvKYaT
	/NVlbHVBnMbNWoBQ4tQYbvCmtIy7VEY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-mnYlW-YxMhy4WfBTtQOmXA-1; Thu, 07 Dec 2023 01:38:42 -0500
X-MC-Unique: mnYlW-YxMhy4WfBTtQOmXA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a0c510419caso27649266b.1
        for <linux-block@vger.kernel.org>; Wed, 06 Dec 2023 22:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701931121; x=1702535921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWU3XhY3SGz8Nm4Q405d0erGPeXKkfHuFXSX394aJLk=;
        b=uZLSzMGO2bQRRUgLsfyQJITWhKhsZLUJZxF7KHXYY779H2oOPOntbiSa39fHACjgGp
         WLxAcvaElpOdFPqDsxrJxPvmG46B0fIEz508m8ZhmJBX6vBea1o9dKdOmt2ppRgd5EBR
         TfiUyfVLu+STUHDuBGu+yYUwSZMlQhWg9R96ONJ89a4wuCbMhnfGj82ReazAbFG21gMX
         4rgf9tX+G9t5KMGa53QSvhd2xrjhf2RBlFTmF+mx2fF6Xso+CdU4u38THm5vj6OZ5uEr
         xjT0wCeoQYKWfpM6z7jKSNVnVbS99zCAAJlZ664+Xm2FKEya7G/4ZO6BirdS1vspzES1
         WKMQ==
X-Gm-Message-State: AOJu0YwBynbkFt5UMvkHr3SwzJ5mZY2Z68FUpcYDNUhkdDzJUDPXjV3c
	+pRyT+M+PnsHWCW9D3JB1VeXweXN5/YJYnSeWIaEHJOPD1+5Ailn6ldI8Jbx9YKnSqwoxIGMkma
	ayCiTjGSXsnfqqCq3Omsjmuo=
X-Received: by 2002:a17:906:412:b0:a19:a1ba:8cdf with SMTP id d18-20020a170906041200b00a19a1ba8cdfmr1283530eja.125.1701931121420;
        Wed, 06 Dec 2023 22:38:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhiBhaS+kmbU1JKx2cAFUfZmT6awaVyiVkat1D9D0v41JMF0DlUXomnGzVKOZQPNjGyvsaNQ==
X-Received: by 2002:a17:906:412:b0:a19:a1ba:8cdf with SMTP id d18-20020a170906041200b00a19a1ba8cdfmr1283523eja.125.1701931121146;
        Wed, 06 Dec 2023 22:38:41 -0800 (PST)
Received: from redhat.com ([2.55.11.67])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906c30600b00a1dee0289b4sm376148ejz.169.2023.12.06.22.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 22:38:40 -0800 (PST)
Date: Thu, 7 Dec 2023 01:38:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231207013617-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
 <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>

On Thu, Dec 07, 2023 at 02:02:36PM +0800, Jason Wang wrote:
> On Thu, Dec 7, 2023 at 12:33 PM Li Feng <fengli@smartx.com> wrote:
> >
> > virtio-blk is generally used in cloud computing scenarios, where the
> > performance of virtual disks is very important. The mq-deadline scheduler
> > has a big performance drop compared to none with single queue.
> 
> At least you can choose the scheduler based on if mq is supported or not?
> 
> Thanks

This is already the case:

static struct elevator_type *elevator_get_default(struct request_queue *q)
{
        if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
                return NULL;

        if (q->nr_hw_queues != 1 &&
            !blk_mq_is_shared_tags(q->tag_set->flags))
                return NULL;

        return elevator_find_get(q, "mq-deadline");
}

I guess I agree blk is typically kind of similar to loopback
so none by default makes sense here same as for loopback.

Stefan care to comment?

-- 
MST

