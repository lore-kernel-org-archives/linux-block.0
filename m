Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8DD2D948B
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584313; cv=none; b=NPiAkvPE8rREY/depzI/GnZqChhwr8DVVYrTAj8pc1i9vA/WU5b/8m1x4mjpvO4iBo5kHPcw7cTzvm2qAURpnYoBbIc/xs9Nq+p9mpXQm+C6vHp7XMBdJCs4kSQcQ16g1mHEeFwSmsSwZ8agK/GgDPT2UZW9pbE4VnOeZWKuaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584313; c=relaxed/simple;
	bh=rJxJmkMjv9hRU1poHNldVepS3PnnBBFEAF0M9FOygeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuefW91x0CW7F7FBbX5V/dkvsdVxkXio7n9ph+wC5QZYtnhq+ub976c/q4X4f0oxNVbcr1z4hneTn6g64Fst76INzY9Jpaoa3I9MroCevLjFfzSWGt0H9ydKPAcyJtbbu2jz8Hsf+U6hf+STBGr/uDw8TqbpwAjdVM8ovaRskQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KNqNJy16; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KNqNJy16"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhK4Q5GcJzm174N;
	Tue, 15 Jul 2025 12:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752584309; x=1755176310; bh=xe7K3OdBh+FNPMbmGNMvhXaN
	jUUA5NFp9Fx1Or9rpRw=; b=KNqNJy168+m2P7XIxQGeigiYZGj4H6O31m+LlbTg
	kuSj83mApghVx7at67rI5EhqIjwBH1nrk9+K0i+JX42503gN8SgCQHRrNwb8aY3C
	9mNxftFj3ExiN2I3MQwxhJtYKCs8J+txsYcTvX4ZFY4XA9mCRdNC41QCo1Fi1z4K
	zvDHRx0vfRAoFLcpZPb/5zbTNK3N6iVDelKGkNP10RY9h9kBOH4FGtF0vbxo8B/5
	H9WUBfj3d2aE7sQ5rAWKmCCVcZoXFi6K048k+GWmD0rInq3zzrd2kkd0Mlj5AjqR
	maJmDVOpSA5bcr3PO+CCK5ueYZOgZDweF+oFvC+8oxNsdw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fe2k-7uyz2qz; Tue, 15 Jul 2025 12:58:29 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhK4J6Dh6zm0yQp;
	Tue, 15 Jul 2025 12:58:22 +0000 (UTC)
Message-ID: <d14a3b85-a950-436f-95c0-62b3c9cd1053@acm.org>
Date: Tue, 15 Jul 2025 05:58:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] loop/010, common/rc: drain udev events after
 test
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Gulam Mohamed <gulam.mohamed@oracle.com>,
 Daniel Wagner <dwagner@suse.de>
References: <20250715043202.28788-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250715043202.28788-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 9:32 PM, Shin'ichiro Kawasaki wrote:
> The test case repeats creating and deleting a loop device. This
> generates many udev events and makes following test cases fail. To avoid
> the unexpected test case failures, drain the udev events. For that
> purpose, introduce the helper function _drain_udev_events(). When
> systemd-udevd service is running, restart it to discard the events
> quickly. When systemd-udevd service is not available, call
> "udevadm settle", which takes longer time to drain the events.
> 
> Link: https://github.com/linux-blktests/blktests/issues/181
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Suggested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Added "udevadm settle" in case systemd-udevd.service is not available
> * Introduced _drain_udev_events()
> 
>   common/rc      | 9 +++++++++
>   tests/loop/010 | 5 +++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 72441ab..dfc389f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -544,6 +544,15 @@ _systemctl_stop() {
>   	done
>   }
>   
> +_drain_udev_events() {
> +	if command -v systemctl &>/dev/null &&
> +			systemctl is-active --quiet systemd-udevd; then
> +		systemctl restart systemd-udevd.service
> +	else
> +		udevadm settle --timeout=900
> +	fi
> +}
> +
>   # Run the given command as NORMAL_USER
>   _run_user() {
>   	su "$NORMAL_USER" -c "$1"
> diff --git a/tests/loop/010 b/tests/loop/010
> index 309fd8a..b1a4926 100755
> --- a/tests/loop/010
> +++ b/tests/loop/010
> @@ -78,5 +78,10 @@ test() {
>   	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
>   		echo "Fail"
>   	fi
> +
> +	# The repeated loop device creations and deletions generated so many
> +	# udev events. Drain the events to not influence following test cases.
> +	_drain_udev_events
> +

How about changing the above comment into the following to make it more 
clear? "This test generates udev events faster than the rate at which
udevd can process events. Drain udev events to prevent that future test
cases fail." Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

