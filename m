Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: partitions: mac: Mark mac_fix_string() as
 __maybe_unused
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170519012454.66962-1-mka@chromium.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5a116ee7-2f03-3f32-fcfa-ca5d6a53b328@kernel.dk>
Date: Fri, 19 May 2017 09:27:49 -0600
MIME-Version: 1.0
In-Reply-To: <20170519012454.66962-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/18/2017 07:24 PM, Matthias Kaehlcke wrote:
> The function is only used when CONFIG_PPC_PMAC=y. Adding the attribute
> fixes the following warning when building with clang:
> 
> block/partitions/mac.c:22:20: error: unused function 'mac_fix_string'
>     [-Werror,-Wunused-function]
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  block/partitions/mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/partitions/mac.c b/block/partitions/mac.c
> index 621317ac4d59..57483faddaac 100644
> --- a/block/partitions/mac.c
> +++ b/block/partitions/mac.c
> @@ -19,7 +19,7 @@ extern void note_bootable_part(dev_t dev, int part, int goodness);
>   * Code to understand MacOS partition tables.
>   */
>  
> -static inline void mac_fix_string(char *stg, int len)
> +static inline void __maybe_unused mac_fix_string(char *stg, int len)
>  {
>  	int i;
>  

Or just put the function inside an CONFIG_PPC_PMAC section?

-- 
Jens Axboe
