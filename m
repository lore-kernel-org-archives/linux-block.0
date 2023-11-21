Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fib8uI8p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4AD63
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 03:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700565680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lvkSTwLNcligk2NfSwpzf/9ZTtYdyR+4H/3O2h42yg=;
	b=fib8uI8p/Szf73DVbfF56cbee3dssPMqc7aveKYbTUdDf+rTdxFkq1/JOXHWQRz8Dqz7AR
	Gmf9bKoNbR9V1aw5q196i24gW+YDJA968scKndL4TC2Rvu8Bd2JQvWqkDWP43H3+P6djjD
	ULFlSahAA/dtomSoXyxORzz9lb7vLfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-7ptcaRWlNuugfGoNXclwYA-1; Tue, 21 Nov 2023 06:21:19 -0500
X-MC-Unique: 7ptcaRWlNuugfGoNXclwYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF9E181B162;
	Tue, 21 Nov 2023 11:21:18 +0000 (UTC)
Received: from fedora (unknown [10.72.120.14])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BBD5020268D0;
	Tue, 21 Nov 2023 11:21:15 +0000 (UTC)
Date: Tue, 21 Nov 2023 19:21:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: move .bd_inode into 1st cacheline of block_device
Message-ID: <ZVySp9kcDmpqcd9n@fedora>
References: <20231121101156.378105-1-ming.lei@redhat.com>
 <b07d6d9b-7926-d5b1-71ab-29640e2a84f8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b07d6d9b-7926-d5b1-71ab-29640e2a84f8@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Tue, Nov 21, 2023 at 07:12:44PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/11/21 18:11, Ming Lei 写道:
> > The .bd_inode field of block_device is used in IO fast path of
> > blkdev_write_iter() and blkdev_llseek(), so it is more efficient to keep
> > it into the 1st cacheline.
> > 
> > .bd_openers is only touched in open()/close(), and .bd_size_lock is only
> > for updating bdev capacity, which is in slow path too.
> > 
> > So swap .bd_inode layout with .bd_openers & .bd_size_lock to move
> > .bd_inode into the 1st cache line.
> 
> This patch looks good, do you want me do take it for a v3 for the
> other patchset?

Yeah, please take it.

> 
> And by the way, can we also move 'int bd_writers' to near 'atomic_t
> bd_fsfreeze_count' to save 8 bytes(int 64bit platform)?
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 07abd0165226..a47ab9249bdd 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -63,11 +63,11 @@ struct block_device {
>         int                     bd_holders;
>         struct kobject          *bd_holder_dir;
> 
> +       int                     bd_writers;
>         atomic_t                bd_fsfreeze_count; /* number of freeze
> requests */
>         struct mutex            bd_fsfreeze_mutex; /* serialize freeze/thaw
> */
> 
>         struct partition_meta_info *bd_meta_info;
> -       int                     bd_writers;

Which tree are you talking about? I don't see 'bd_writers' in both
linus tree and block-6.7, and for-6.8/block isn't open yet.

Thanks,
Ming

