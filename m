Subject: Re: Sed-opal fixups
To: Scott Bauer <scott.bauer@intel.com>,
 David Laight <David.Laight@ACULAB.COM>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
 <063D6719AE5E284EB5DD2968C1650D6DB0281B85@AcuExch.aculab.com>
 <20170209174526.GA5200@sbauer-Z170X-UD5>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "hch@infradead.org" <hch@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <45bcab45-3efa-e817-911a-ec3a0924dc6b@fb.com>
Date: Thu, 9 Feb 2017 11:24:58 -0700
MIME-Version: 1.0
In-Reply-To: <20170209174526.GA5200@sbauer-Z170X-UD5>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/09/2017 10:45 AM, Scott Bauer wrote:
> On Thu, Feb 09, 2017 at 05:43:20PM +0000, David Laight wrote:
>> From: Scott Bauer
>>> Sent: 09 February 2017 17:20
>>> It may be too late to change anyhting in the uapi header. When we
>>> switched over to using IOC_SIZE I found a bug where I had switched
>>> up a structure in one of the series from v4 to v5 but never changed
>>> the structure in the IOW. The structure that was in there was to small
>>> so when we kzalloc on it we don't request enough space. It worked before
>>> because we were using the cmd strictly as a command #, not using the IOC
>>> and friends.
>>>
>>> If it's too late to modify that IOW, I can work around it by reallocing
>>> on the correct size for that command only. I verified the rest of the
>>> commands and the structures are the same.
>>>
>>> Let me know what you think, please.
>>
>> Maybe define IOC_OPAL_ACTIVATE_LSP_OLD to the incorrect value and
>> IOC_OPAL_ACTIVATE_LSP to the correct one.
>> But that relies on any users specifying the correct structure.
>> I wouldn't guarantee that.
> 
> I think I'm the only userspace user right now, this went in on monday,
> so I can can change my tooling easily. I just wasnt sure if there was a
> set time where the user ABI cannot be changed.

We can still change it, and we definitely should if it improves the
interface. It's not a ABI until it's in a released, final kernel.

-- 
Jens Axboe
