Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8B3B893D
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072757; cv=none; b=szXL58c/xD+qo9U8mK2RRkPLtGwM7AXWcSV7dIojouRG9yyPYXbENfRkdrb6j8fJ9dI5uesfrIkMHuVNv2UY/H5gcenrP9eVvDBdW0BdEUUJPL51yW7tzZCdgPP/riDBKirHIw6BuastSP8UX895sKGe++D+fyraBzssKNPaiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072757; c=relaxed/simple;
	bh=e1AKI+bCKQbWCoFU9e4RZd9y4sbLesngNc7PnzpU/KU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mkHGoubktMQXHWomv1F1tY4ch2BrhYEICUMPPPPJ605R4fff6PV0j60+9o7PyJu5tvWk4go9oudeOqPSP/9Dd1zNko7CGum/cmZSMkqEDlcoZiG5Jyez32rDopKOTTD8AQn2CZQTKUhIbqoha4A+fwCd3R9p0eO1W5JpDNrnZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ld+FD1cz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld+FD1cz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773072753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gnnyUL0n6EDT1Fhp8qXg6+M1hpcHUbUUrCiGO+2l/A=;
	b=Ld+FD1czRpECu+DuiVDK2ssgHRUwdLzgKGjqWylu1xpR2bq5vM9t/dC65wvxNZ1lcbNFp4
	DP8sQ4Gyobx3LvNS6KlCx9uwwKNRtQV/ynoDoa2VTvv5YcEmwWpUaFjxxbcdmu1kmo3YS1
	SxFxFbrfegps1r9xfaz7Wo6XW+cfebI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-yqA2XdDOM0aCU0b3yaFr-g-1; Mon,
 09 Mar 2026 12:12:27 -0400
X-MC-Unique: yqA2XdDOM0aCU0b3yaFr-g-1
X-Mimecast-MFC-AGG-ID: yqA2XdDOM0aCU0b3yaFr-g_1773072746
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E887180035D;
	Mon,  9 Mar 2026 16:12:25 +0000 (UTC)
Received: from [10.44.32.29] (unknown [10.44.32.29])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CED171956095;
	Mon,  9 Mar 2026 16:12:22 +0000 (UTC)
Date: Mon, 9 Mar 2026 17:12:19 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Linlin Zhang <linlin.zhang@oss.qualcomm.com>, linux-block@vger.kernel.org, 
    ebiggers@kernel.org, linux-kernel@vger.kernel.org, adrianvovk@gmail.com, 
    dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, gmazyland@gmail.com, 
    israelr@nvidia.com
Subject: Re: [PATCH v1 1/3] block: export blk-crypto symbols required by
 dm-inlinecrypt
In-Reply-To: <4d46676d-e738-497c-b848-4278ec15d868@kernel.dk>
Message-ID: <9ca23050-7ea6-e1d2-004a-807912379a21@redhat.com>
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com> <20260304121729.1532469-2-linlin.zhang@oss.qualcomm.com> <4d46676d-e738-497c-b848-4278ec15d868@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Mon, 9 Mar 2026, Jens Axboe wrote:

> On 3/4/26 5:17 AM, Linlin Zhang wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > bio_crypt_set_ctx(), blk_crypto_init_key(), and
> > blk_crypto_start_using_key() are needed to use inline encryption; see
> > Documentation/block/inline-encryption.rst.  Export them so that
> > dm-inlinecrypt can use them.  The only reason these weren't exported
> > before was that inline encryption was previously used only by fs/crypto/
> > which is built-in code.
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 
> -- 
> Jens Axboe

Thanks.

Mikulas

