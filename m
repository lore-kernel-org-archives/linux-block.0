Subject: Re: [Nbd] [PATCH 0/5] nbd improvements
To: Wouter Verhelst <w@uter.be>
References: <1473363221-142264-1-git-send-email-jbacik@fb.com>
 <aee66977-c8f2-dab7-0649-f4e71fdc31f8@fb.com>
 <20160909200816.spdbyericjehvmcq@grep.be>
Cc: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@fb.com, mpa@pengutronix.de,
 nbd-general@lists.sourceforge.net
From: Jens Axboe <axboe@fb.com>
Message-ID: <046ee110-1951-be3b-9251-fbd03bef9f53@fb.com>
Date: Fri, 9 Sep 2016 14:26:21 -0600
MIME-Version: 1.0
In-Reply-To: <20160909200816.spdbyericjehvmcq@grep.be>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/09/2016 02:08 PM, Wouter Verhelst wrote:
> Hi Jens,
>
> On Thu, Sep 08, 2016 at 02:13:46PM -0600, Jens Axboe wrote:
>> Not only are these nice performance improvements, it also cleans up the
>> code a lot and kills crufty old driver code in favor of using the proper
>> APIs instead. I have applied the series for 4.9.
>
> Please ensure that the comments I made in my other mail are addressed
> before you push this to Linus; otherwise this will result in significant
> problems for userspace (that it would then be my responsibility to deal
> with).

We've got some time to hash this out, before it goes upstream. I agree
on the 'pid' file being an issue, we need to bring that back to avoid
breaking userspace.

For the other part, Josef, did you test the multiple connection setup
against re-connection?

-- 
Jens Axboe
