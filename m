Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7CF234966
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438924; cv=none; b=P/DT1c/neuBfQQn7hd9fK543T1+LIgkIwprVyCAHR6zYiVYdBcLny10HL4UAlVS/DQzHR8fAHVLgsz338ieD4BpfabSLEf6QRzc9G5w8PqD0uLMYgMBLOvKHq/nOkj/Pxm14iVvoUPOpGQ1k69y/Apf96S8TJrrWtLEN9XGVsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438924; c=relaxed/simple;
	bh=qRWOUa0k/wT6GJblhMCiQ04nkWCuD82sP0yxG/sxFs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GWdph9gwfbqJX+rXrnbUAryXXh9xOu8fVdmvDwxhz/e9bVR7vtC+ls6A8IFFHigF5MytBQbXE/FQnwWByiNoXlGg2X2//w0n8o7q6iQujZSe3KKPHkn8q6edtMUr1neMKkn6/iGehl9O2wq+x1yCfznp7gVEiAkcaL+M9J0ILIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlFJpu84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlFJpu84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802B6C4CEE7;
	Fri, 25 Jul 2025 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753438923;
	bh=qRWOUa0k/wT6GJblhMCiQ04nkWCuD82sP0yxG/sxFs0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JlFJpu84E0rgl1Dbp6Opo7xJ2AHxA0kyWmpDH16bI8TZnpFl2nRAD4XqGgdbZqvvS
	 CR1TcuLHMdYKUZ8tVnsvGlngjPH8gnHrvdjAWkqtRCwT+GCiSUANsNQ2bwI5OsGOJS
	 plER7Jzfgo+l5aMmN//uWBjS2G/cXcZGT1pdSmA3Us0lvnAd8zfcEwsutVhcDAuAlO
	 SHWEqxeg4O5KCJXRh7yyVut/8OO8b0gDL2CzfqQovRGWQsWobLjfPaUPiVslHfl/LX
	 BF0pgwmc0DP2pXZ52K/Im2WdFVYepeFizMQ670wbaBbdeFAPD/gMwKa5GnRpZB9kq2
	 eZfoNnkR4BELw==
Message-ID: <c7149c3b-52a5-4144-aece-a9cac5068dca@kernel.org>
Date: Fri, 25 Jul 2025 19:22:02 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] zbd/005: remove offset option of blkzone reset
 command
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20250725080856.232478-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250725080856.232478-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/25 17:08, Shin'ichiro Kawasaki wrote:
> The test case zbd/005 performs sequential writes to all sequential
> write required zone on the test target zoned block device. To prepare
> the device for this operation, the test invokes the blkzone reset
> command. However, it takes very long time to complete.
> 
> The root cause of the long reset time is the offset option of the
> blkzone reset command. This option specifies the first sequential write
> required zone. When the offset options is provided, the kernel processes
> the reset operation zone by zone. As a result, a separated zone reset
> command is issued to each sequential write required zone, significantly
> increasing the overall time.
> 
> To reduce the execution time of the blkzone reset command, remove the
> offset option. Without this option, the kernel can perform a single zone
> reset operation that resets all sequential write required zones.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
