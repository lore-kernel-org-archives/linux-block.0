Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28F18DB14;
	Fri, 27 Jun 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032809; cv=none; b=OIjanm6d4XvERmrZmPXlRFEoPZwmK249OJ0qovYtb9yMMc8JZ59nuXcidXu1mm+6glfLwmYulrQdbeNjYvKNPt6Ywbi/DmR4nc3T8qCDxBNVxXypK19Rx0zIU6AKiHHfvLnUZ3IMTkgeE5WeLAfyZxo7bATfZQnDmKCg0ARJGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032809; c=relaxed/simple;
	bh=9PsIdObdQYdLva1DL+FRjtpGjZk7PWQC7B36NSZIapU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WojDv+LOVyll0it0yRebK0jxPtboHspX3xe/1DIO96RDup7W6Si3BemVBbroovbfVOXObf4otVYWPogoKf5YMbfvZRQtI+8JIuI0sJDWCnHWG+7DgfE5Iy8bzrByos4Bt6WO9Mao3CPATl6Iz1g1mLyGVxD4lqymQoZjSR4eOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYXbDRFa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYXbDRFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBB6C4CEED;
	Fri, 27 Jun 2025 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751032809;
	bh=9PsIdObdQYdLva1DL+FRjtpGjZk7PWQC7B36NSZIapU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYXbDRFaRuex7XrmOT9aL2vjzn7DEqPQlMZzr+KQHHKPuPn/nl40Hho03cZTYSOyh
	 lfk/iG/2mA6Y+6FVG5T2yianqQmVUnYwCDBs9YhikJEAeyLGvSZNHmJj3gbGL+/qHq
	 hFBRezGVA8hJE5L6XLPOXRXcGw3JZJnucbqTutpPHwKt0IkWUBBB/N3GKeG/DnQa0T
	 qdcdTszvYieCrWKbuQTGehoq0jWz1y+0UOdGxN1A5Q2Y30/3MTE1e2iwD8Rz20eDvv
	 fhedfdoNyCs0oBmnpHbJJGmmUdF5+UcXcKomaI8xeBz8Qy2moVJpOdW5R4duRhVZ6r
	 rbgs+xDUbqLNQ==
Date: Fri, 27 Jun 2025 08:00:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <aF6j5U2qOi3v0Jf_@kbusch-mbp>
References: <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626023324-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71958505493CE570B5C519A0DC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250627082048-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627082048-mutt-send-email-mst@kernel.org>

On Fri, Jun 27, 2025 at 08:21:16AM -0400, Michael S. Tsirkin wrote:
> 
> You did, thanks! How do other drivers handle this? The issue seems generic.

They implement blk_mq_ops' ".timeout" callback, which appears to be
missing in virtio_mq_ops.
