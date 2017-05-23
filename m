Subject: Re: [PATCH] nbd: don't leak nbd_config
To: Josef Bacik <josef@toxicpanda.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org
References: <1495535911-29036-1-git-send-email-idryomov@gmail.com>
 <20170523141445.GA1568@destiny>
From: Jens Axboe <axboe@fb.com>
Message-ID: <8e9d481e-462e-c3f7-8c35-d80f87d1de9a@fb.com>
Date: Tue, 23 May 2017 08:16:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170523141445.GA1568@destiny>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/23/2017 08:14 AM, Josef Bacik wrote:
> On Tue, May 23, 2017 at 12:38:31PM +0200, Ilya Dryomov wrote:
>> nbd_config is allocated in nbd_alloc_config(), but never freed.
>>
>> Fixes: 5ea8d10802ec ("nbd: separate out the config information")
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  drivers/block/nbd.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Oops, thanks Ilya
> 
> Reviewed-by: Josef Bacik <jbacik@fb.com>

Since config is referenced, why isn't this done in nbd_config_put()
instead?

-- 
Jens Axboe
