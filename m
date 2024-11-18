Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3315534E
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928120; cv=none; b=BOa0WC7N34peEnHph+vTw7Ga7dZfb1X/Lo/HGX3ZXkbMun89cenE4mftMytVI10oAk59hQ5NpSBvRzO4NZhnjmYIKCuYtA2JWmF3wxZxYXCUe0cDRBeNdIxGpHB72eWCyy4sIiXuha9UYt95SLS0JjPx8PS7jEb1WEiHF31ztjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928120; c=relaxed/simple;
	bh=Z5bh5DnDsQDrS6FoK6+ye1rLMwWyfxDyedFBx9cd6Rc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U3gHdvl7SYzNehu+y3yI60sTyuXeKA4eVzELsHSR0a/FiU/EgnxA3A3UxT4ptXQGnqgop6yqAPyJ7RdZVBJIFFZA9U5SBCxAAbe/m/HTKoHtfJCMM+h21oSIbFBjyd1WUz1SkHzPFaqmS29qxOq5/Nk5XWvK3aIdkwEuL/1K7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsPxT3tcQz4f3pJC
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 19:08:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D56931A0359
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 19:08:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCXcYUvIDtndIGICA--.56774S3;
	Mon, 18 Nov 2024 19:08:32 +0800 (CST)
Subject: Re: [PATCH blktests] throtl: set "io" to subtree_control only if
 required
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20241115121224.173285-1-shinichiro.kawasaki@wdc.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <15cab907-aef7-a378-5431-490ed000201c@huaweicloud.com>
Date: Mon, 18 Nov 2024 19:08:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241115121224.173285-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXcYUvIDtndIGICA--.56774S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1xXF47Cw13XF4rXr18Krg_yoW8KFW8pr
	ZrGw4ftayfJ3ZxAr18tF10gFWfZw48X3ZrtFZ8JryfKr4fJ3WfK3yUZr15XFyrAFs3Xr4r
	Aa90y3WfCw1qywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/11/15 20:12, Shin'ichiro Kawasaki Ð´µÀ:
> It was reported the thortl test cases fail on the systems, which already
> sets "io" in cgourp2 subtree_control files. The fail happens when
> writing "-io" to the subtree_control files at clean up.
> 
> To avoid the failure, check if the system already sets "io". If so, skip
> writing "+io" at set up, and writing "-io" at clean up.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://github.com/osandov/blktests/issues/149
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/throtl/rc | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 

LGTM, thanks for the patch
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/tests/throtl/rc b/tests/throtl/rc
> index 2e26fd2..9c264bd 100644
> --- a/tests/throtl/rc
> +++ b/tests/throtl/rc
> @@ -10,6 +10,8 @@
>   
>   THROTL_DIR=$(echo "$TEST_NAME" | tr '/' '_')
>   THROTL_DEV=dev_nullb
> +declare THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO
> +declare THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO
>   
>   group_requires() {
>   	_have_root
> @@ -31,8 +33,16 @@ _set_up_throtl() {
>   		return 1
>   	fi
>   
> -	echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
> -	echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
> +	THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO=
> +	THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO=
> +	if ! grep -q io "$(_cgroup2_base_dir)/cgroup.subtree_control"; then
> +		echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
> +		THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO=true
> +	fi
> +	if ! grep -q io "$CGROUP2_DIR/cgroup.subtree_control"; then
> +		echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
> +		THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO=true
> +	fi
>   
>   	mkdir -p "$CGROUP2_DIR/$THROTL_DIR"
>   	return 0;
> @@ -40,8 +50,12 @@ _set_up_throtl() {
>   
>   _clean_up_throtl() {
>   	rmdir "$CGROUP2_DIR/$THROTL_DIR"
> -	echo "-io" > "$CGROUP2_DIR/cgroup.subtree_control"
> -	echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
> +	if [[ $THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO == true ]]; then
> +		echo "-io" > "$CGROUP2_DIR/cgroup.subtree_control"
> +	fi
> +	if [[ $THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO == true ]]; then
> +		echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
> +	fi
>   
>   	_exit_cgroup2
>   	_exit_null_blk
> 

