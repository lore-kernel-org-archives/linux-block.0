Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57B1D1E60;
	Wed,  2 Oct 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903250; cv=none; b=Fbj6ixs1L6g0O1TxDh9UVe1ICw2ypn2/bGCe8yVdtHpGxVm1q2z8/vdO/ImI0/1Z27WYesTXbHu7CB9+u/nzR0U9tzqscLIXopeUH5c0UOjDTineqwEfK9+RCSA09Za/2d76BorK0337x6UvvRvxyh/0h4emJe0ydfeS0O2hTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903250; c=relaxed/simple;
	bh=QlKXgfdBzCjAMlafbWFDRc/1QG/qB5nvbcq+O867xZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEsOC0OpT56cVpftlGm+wQnpIi80JFknxPVaGN3lQvSMllYYkTpvis7XPwlEkzCNTHJEx3jeJe6SwQ9IkkktY9z+TnyXqDyhe2Glv2l3HhhjEH44Q8kjk1WWlzyzW1tUTeyQUY4Q0vMu0sxisIuMArdnqKsMhFvitwhBQd55B4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdspXwWl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdspXwWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BABFC4CEC2;
	Wed,  2 Oct 2024 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727903249;
	bh=QlKXgfdBzCjAMlafbWFDRc/1QG/qB5nvbcq+O867xZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdspXwWlB6+f09ApuSoqDL0TGh5k/C1upAfixu5CMyKZXkjodpKG+YztyrM8FB51Q
	 U6XPxBARwaqpmD1dCz1Pbn9+8mJ6mUdzlpOrIvutVSDeAGLP7/TZ9RY5IwNZ72BswK
	 6o45z2MKlqjR/idiZe+LDMRtl7kwM5w9RqHQoeyOtEOCcVfnRp/KspgKP9X8S6hvWa
	 pPVruRrg0bA59TcwHFRuD3yFUt5Im/PJf24ApRoxiLR2hKyVRUehnc/ihNJm4yzCkT
	 TDfYjJLhzKPEpUpf4kKysNxfonMjY4HOg/C3yHY0t8f80TySGvo6lTU9GoiIvcXomY
	 9NYO2RKrdqMxw==
Date: Wed, 2 Oct 2024 16:07:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: upstream@airoha.com, Mikko Rapeli <mikko.rapeli@linaro.org>,
	linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Conor Dooley <conor+dt@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	linux-block@vger.kernel.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Heusel <christian@heusel.eu>,
	Jonathan Corbet <corbet@lwn.net>, linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, devicetree@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 6/6] dt-bindings: mmc: Document support for partition
 table in mmc-card
Message-ID: <172790324832.1315949.14972458101989474417.robh@kernel.org>
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
 <20241001221931.9309-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001221931.9309-7-ansuelsmth@gmail.com>


On Wed, 02 Oct 2024 00:18:58 +0200, Christian Marangi wrote:
> Document support for defining a partition table in the mmc-card node.
> 
> This is needed if the eMMC doesn't have a partition table written and
> the bootloader of the device load data by using absolute offset of the
> block device. This is common on embedded device that have eMMC installed
> to save space and have non removable block devices.
> 
> If an OF partition table is detected, any partition table written in the
> eMMC will be ignored and won't be parsed.
> 
> eMMC provide a generic disk for user data and if supported (JEDEC 4.4+)
> also provide two additional disk ("boot1" and "boot2") for special usage
> of boot operation where normally is stored the bootloader or boot info.
> New JEDEC version also supports up to 4 GP partition for other usage
> called "gp1", "gp2", "gp3", "gp4".
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

