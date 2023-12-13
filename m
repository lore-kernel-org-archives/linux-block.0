Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M9Rgjoxa"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [IPv6:2001:41d0:203:375::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA2D5
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 04:15:32 -0800 (PST)
Message-ID: <78c25a62-44d5-d40d-a3e8-1f40a0c95c11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702469278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DU7Ue/NZBO61kVWg5eFser6LJMK31DbbsBvBIKnZORg=;
	b=M9Rgjoxa+lySX3pH1qW05LzgbxUlUivYz+67rZWH7OnWNUGzpfJfodxrwxDf3aTZGSjyCh
	Gym/H14JCLFf7PtGmTW1bLpnkva18xTx4uSPQInOeIZiqMtOLtahvjjkmIV9kBQ1GVdIcy
	clznz3LNmOcfVDly6+Iuj6mCQcqxQ+0=
Date: Wed, 13 Dec 2023 20:07:51 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block/rnbd-srv: Check for unlikely string overflow
To: Kees Cook <keescook@chromium.org>, "Md. Haris Iqbal"
 <haris.iqbal@ionos.com>
Cc: kernel test robot <lkp@intel.com>, Jack Wang <jinpu.wang@ionos.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231212214738.work.169-kees@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20231212214738.work.169-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/13/23 05:47, Kees Cook wrote:
> Since "dev_search_path" can technically be as large as PATH_MAX,
> there was a risk of truncation when copying it and a second string
> into "full_path" since it was also PATH_MAX sized. The W=1 builds were
> reporting this warning:
>
> drivers/block/rnbd/rnbd-srv.c: In function 'process_msg_open.isra':
> drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output may be truncated writing up to 254 bytes into a region of size between 0 and 4095 [-Wformat-truncation=]
>    616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
>        |                                                   ^~
> In function 'rnbd_srv_get_full_path',
>      inlined from 'process_msg_open.isra' at drivers/block/rnbd/rnbd-srv.c:721:14: drivers/block/rnbd/rnbd-srv.c:616:17: note: 'snprintf' output between 2 and 4351 bytes into a destination of size 4096
>    616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    617 |                          dev_search_path, dev_name);
>        |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> To fix this, unconditionally check for truncation (as was already done
> for the case where "%SESSNAME%" was present).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312100355.lHoJPgKy-lkp@intel.com/
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/block/rnbd/rnbd-srv.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 65de51f3dfd9..ab78eab97d98 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -585,6 +585,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
>   {
>   	char *full_path;
>   	char *a, *b;
> +	int len;
>   
>   	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
>   	if (!full_path)
> @@ -596,19 +597,19 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
>   	 */
>   	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
>   	if (a) {
> -		int len = a - dev_search_path;
> +		len = a - dev_search_path;
>   
>   		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
>   			       dev_search_path, srv_sess->sessname, dev_name);
> -		if (len >= PATH_MAX) {
> -			pr_err("Too long path: %s, %s, %s\n",
> -			       dev_search_path, srv_sess->sessname, dev_name);
> -			kfree(full_path);
> -			return ERR_PTR(-EINVAL);
> -		}
>   	} else {
> -		snprintf(full_path, PATH_MAX, "%s/%s",
> -			 dev_search_path, dev_name);
> +		len = snprintf(full_path, PATH_MAX, "%s/%s",
> +			       dev_search_path, dev_name);
> +	}
> +	if (len >= PATH_MAX) {
> +		pr_err("Too long path: %s, %s, %s\n",
> +		       dev_search_path, srv_sess->sessname, dev_name);
> +		kfree(full_path);
> +		return ERR_PTR(-EINVAL);
>   	}
>   
>   	/* eliminitate duplicated slashes */

Looks good.

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
