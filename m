Subject: Re: [PATCH 6/7] pktcdvd: use class_groups instead of class_attrs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Christie <mchristi@redhat.com>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <20170608081242.27061-1-gregkh@linuxfoundation.org>
 <20170608081242.27061-7-gregkh@linuxfoundation.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <858fcb8a-90d4-a5c5-a75b-5b8a69c3e6f8@fb.com>
Date: Thu, 8 Jun 2017 08:05:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170608081242.27061-7-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/08/2017 02:12 AM, Greg Kroah-Hartman wrote:
> The class_attrs pointer is long depreciated, and is about to be finally
> removed, so move to use the class_groups pointer instead.

Feel free to add my Acked-by to this.

-- 
Jens Axboe
