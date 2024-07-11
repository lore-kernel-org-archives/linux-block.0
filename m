Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB515ECD2
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705176; cv=none; b=i9ftLOBnSemT9B/EZ0x7lCCX0cQWQ2bfrmxBeV+Un/AkbeSQiYliNlm9bBFgoo1OOLQgLZVH16/SiSgfKd2gOxORoVaVd9EsZhLr95Af+VRCZ1Kdz4ChbrNxi0TMdpfOGUyqket9YRnmvYSMYeYavcaZnQRoLrqg8zJFeJAQSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705176; c=relaxed/simple;
	bh=CeSSr2GqviLyMzCik5Kr4s5kuUTTZQ3UDFiw/cyQh70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWgKjMCOV4NBIJ2viRpqJ0qenjKj/ZhDyBMJ7nxO4loxNWeiWkteYwTqJcP1BCCFtublO6fCEJcRgbrfVu4APsohHcOU+EA9X6mP4bHCK0gMfURFzNP7N7z9+YqH/VBmBQ999FYX7mSfKr+Ke73m45bY/CmXfZONbMBlT1yel7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI7Z+Fyq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI7Z+Fyq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720705172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw4qu9/yffnQvKdNYrdZGLZ+gcH1BeP3yFHuxOgKb68=;
	b=ZI7Z+FyqA+dfPsCdfp8Z278F5a776OPDPXIE6yWQ+uAqP7ucZcxmDqHlHVPodUSeshjK/A
	qn6yENxBXBy1OZvWap1g/+LjgSZoH6WTa9r+ePOpDxhlr39sh2fwJIuL8jrzlbjwZQ/BBY
	J563TnljAcclbZYUkzZMpSSCnePogXQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-KgO0v2kvNEGbsmhc6h3V2w-1; Thu,
 11 Jul 2024 09:39:19 -0400
X-MC-Unique: KgO0v2kvNEGbsmhc6h3V2w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C54BF1955BD2;
	Thu, 11 Jul 2024 13:39:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.44])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10A941955F3B;
	Thu, 11 Jul 2024 13:39:11 +0000 (UTC)
Date: Thu, 11 Jul 2024 21:39:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: YangYang <yang.yang@vivo.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-ID: <Zo/gevNqftePGvic@fedora>
References: <20240710065616.1060803-1-yang.yang@vivo.com>
 <29e50fff-fa7f-4b92-bfe9-7665c934b7dc@acm.org>
 <ead047aa-d9dc-4b2f-869f-610b309b5092@vivo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ead047aa-d9dc-4b2f-869f-610b309b5092@vivo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Jul 11, 2024 at 08:48:03PM +0800, YangYang wrote:
> On 2024/7/11 3:54, Bart Van Assche wrote:
> > On 7/9/24 11:56 PM, Yang Yang wrote:
> > > +    /**
> > > +     * @swap_lock: Held while swapping word <-> cleared
> > > +     */
> > > +    spinlock_t swap_lock;
> > 
> > Why is only swapping 'word' with 'cleared' protected by the spinlock?
> > If all 'cleared' changes would be protected by this spinlock then
> > that would allow to eliminate the expensive xchg() call from
> > sbitmap_deferred_clear().
> 
> The spinlock was initially introduced in ea86ea2cdced ("sbitmap:
> ammortize cost of clearing bits").
> I think if all 'cleared' changes are protected by the spinlock, the
> overhead of clearing tags would definitely increase.

There are only two WRITE on 'cleared':

- xchg(&map->cleared, 0) in sbitmap_deferred_clear()

- set_bit() in sbitmap_deferred_clear_bit()

xchg() supposes to provide such protection already.

Thanks,
Ming

