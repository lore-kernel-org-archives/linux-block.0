Subject: Re: [PATCH] nbd: reset the setup task for NBD_CLEAR_SOCK
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
 nbd-general@lists.sourceforge.net, kernel-team@fb.com
References: <1481208755-24700-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <2365ed5f-849e-9999-1a3c-10393abeeb07@fb.com>
Date: Thu, 8 Dec 2016 15:27:09 -0700
MIME-Version: 1.0
In-Reply-To: <1481208755-24700-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 07:52 AM, Josef Bacik wrote:
> If an app exits before running NBD_DO_IT but after adding sockets we can
> end up not being allowed to do a new nbd device.  Fix this by making
> NBD_CLEAR_SOCK reset the setup_task.

Applied, thanks Josef.

-- 
Jens Axboe
